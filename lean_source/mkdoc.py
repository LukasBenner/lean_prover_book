import regex
from pathlib import Path
import os 


# Regular expressions.
main_mode = regex.compile(r'--\s*EXAMPLES:.*|/-\s*EXAMPLES:.*|EXAMPLES:\s*-/.*')
both_mode = regex.compile(r'--\s*BOTH:.*|/-\s*BOTH:.*|BOTH:\s*-/.*')
solutions_mode = regex.compile(r'--\s*SOLUTIONS:.*|/-\s*SOLUTIONS:.*|SOLUTIONS:\s*-/.*')
omit_mode = regex.compile(r'--\s*OMIT:.*|/-\s*OMIT:.*|OMIT:\s*-/.*')
tag_line = regex.compile(r'--\s*TAG:.*')
text_start = regex.compile(r'/-\s*TEXT:.*')
text_end = regex.compile(r'TEXT\.\s*-/.*')
quote_start = regex.compile(r'--\s*QUOTE:.*')
quote_end = regex.compile(r'--\s*QUOTE\..*')
literalinclude = regex.compile(r'--\s*LITERALINCLUDE:\s*(.*)')

# Used to avoid name collisions.
dummy_chars = 'αα'
root = Path(os.path.dirname(os.path.realpath(__file__)))

def CreateChapter(chapter_name: str):
  rst_chapter_path = root.resolve().parent/'source'/chapter_name
  if not rst_chapter_path.exists():
    rst_chapter_path.mkdir()
  return rst_chapter_path
  
def CreateLeanChapter(chapter_name: str):
  lean_chapter_path = root.resolve().parent/'src'/chapter_name
  if not lean_chapter_path.exists():
    lean_chapter_path.mkdir(parents=True)
  return lean_chapter_path


def CreateLeanSolutionsPath(lean_chapter_path:str):
  lean_solutions_path = lean_chapter_path/'solutions'
  if not lean_solutions_path.exists():
    lean_solutions_path.mkdir()
  return lean_solutions_path


def ExtractContents(source_path, rst_path, lean_file_path, solutions_path):
  with source_path.open(encoding='utf8') as source_file, \
            rst_path.open('w', encoding='utf8') as rst_file, \
            lean_file_path.open('w', encoding='utf8') as lean_file, \
            solutions_path.open('w', encoding='utf8') as solutions:
        mode = 'both'
        quoting = False
        line_num = 0
        for line in source_file:
            line_num += 1

            # Check for command.
            if main_mode.match(line):
                mode = 'main'
            elif both_mode.match(line):
                mode = 'both'
            elif solutions_mode.match(line):
                mode = 'solutions'
            elif omit_mode.match(line):
                mode = 'omit'
            elif tag_line.match(line):
                # For quoting from the source; simply remove from output.
                pass
            elif text_start.match(line):
                mode = 'text'
            elif text_end.match(line):
                mode = 'main'
                
            elif quote_start.match(line):
                if quoting:
                    raise RuntimeError(
                        "{0}: '-- QUOTE:' while already quoting".format(line_num))
                if mode == 'text':
                    raise RuntimeError("{0}: '-- QUOTE:' while in text mode".format(line_num))
                
                rst_file.write('\n.. code-block:: lean\n\n')
                quoting = True

            elif quote_end.match(line):
                if not quoting:
                    raise RuntimeError("{0}: '-- QUOTE.' while not quoting".format(line_num))
                rst_file.write('\n')
                quoting = False

            elif match_literalinclude := literalinclude.match(line):
                tag = match_literalinclude.group(1)
                rst_file.write(".. literalinclude:: /../lean_source/{}/source_{}.lean\n".format(chapter_name, section_name))
                rst_file.write("   :start-after: -- TAG: {}\n".format(tag))
                rst_file.write("   :end-before: -- TAG: end\n")


            # There was no command, write the line to the file.
            else:
                line = line.replace(dummy_chars, '')
                if mode == 'main':
                    lean_file.write(line)
                elif mode == 'solutions':
                    solutions.write(line)
                elif mode == 'both':
                    lean_file.write(line)
                    solutions.write(line)
                elif mode == 'omit':
                    pass
                elif mode == 'text':
                    rst_file.write(line)
                else:
                    raise RuntimeError("unexpected mode")
                
                if quoting and mode != 'solutions':
                    # Write the lean code into the document
                    rst_file.write('  ' + line)


if __name__ == '__main__':
    
  for dirpath, dnames, fnames in os.walk(root):
    for f in fnames:
      if f.endswith(".lean"):

        source_path = Path(os.path.join(dirpath, f))

        chapter_name = source_path.parent.name
        section_name = source_path.stem

        print(chapter_name + " " + section_name)

        rst_chapter_path = CreateChapter(chapter_name)
        rst_path = rst_chapter_path/(section_name + '.inc')

        lean_chapter_path = CreateLeanChapter(chapter_name)
        lean_file_path = lean_chapter_path/(section_name + '.lean')

        lean_solutions_path = CreateLeanSolutionsPath(lean_chapter_path)
        solutions_path = lean_solutions_path/('solutions_' + section_name + '.lean')

        ExtractContents(source_path, rst_path, lean_file_path, solutions_path)