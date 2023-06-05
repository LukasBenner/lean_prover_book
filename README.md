# Template for a book about the lean prover

This is the source code for [your book](https://github.com/NAME/BOOK).

Our build process is rudimentary and not ready for prime time, but it is fairly
convenient to use. Most of the source is written directly in the `.lean` files
in `lean_source` using some simple markup. The Python script `mkdoc.py` then generates the `.rst` source for the textbook and an exercise file and a solution file for each section.

To edit the Lean files, you need to have Lean 3 installed. The command

```bash
leanproject get-mathlib-cache
```

installs the required version of the mathlib and caches the build files. 

## How to install

To compile the source code, you'll need the following tools installed:

- Python

- Sphinx

- ReadTheDocs theme

- TeXLive (only if you want to build a PDF)

To [install](https://sphinx-rtd-tutorial.readthedocs.io/en/latest/install.html) Sphinx run `(sudo) pip install sphinx`. After that, install the ReadTheDocs theme with `(sudo) pip install sphinx-rtd-theme`. To install TexLive, follow the instructions of the official [documentation](https://www.tug.org/texlive/).

Use the [cheatsheet](restructuredText_Cheatsheet.rst) to get to know the syntax of the reST-Format

## How to configure

Before building the book, you should configure the meta information. We recomment using the search and replace function of VS Code. Search the following strings and replace them with real information. Most of the configuration is done in the `source/conf.py` but some values are located in `index.rst`, `deploy.sh` and `deploy.ps1`

| Key                      | Location                                           | Explanation                                                          |
| ------------------------ | -------------------------------------------------- | -------------------------------------------------------------------- |
| TITLE OF THE BOOK        | conf.py, index.rst                                 | The title.                                                           |
| SUBTITILE                | conf.py                                            | The subtitle.                                                        |
| MAX MUSTERMANN           | conf.py                                            | The author.                                                          |
| BOOK_FILE_NAME           | conf.py, deploy.sh, deploy.ps1, Make.bat, Makefile | The filename without the file extension used for the LaTeX document. |
| git@github.com:DEST_REPO | deploy.sh, deploy.ps1                              | The link to your destination repository.                             |

## How to build

Run the following command to build the reStructuredText  files, the exercise and solution files.

```bash
python ./lean_source/mkdoc.py
```

The command

```bash
make html
```

build the html book and places it in the `build` folder. The command

```bash
make latexpdf
```

build the pdf textbook instead.

The script `deploy.sh` is used to deploy everything to your destination repository. Make sure to activate GitHub Pages with GitHub Actions for that repository. To activate, under `settings/pages` change the `Source` from `Deploy from a branch` to `GitHub Actions`.
