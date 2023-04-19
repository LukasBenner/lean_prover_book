# Template for a book about the lean prover

This repository holds the sourcecode of the book and the lean files.

Der Inhalt wird mittels Markup in `.lean` Dateien in `lean_source` verfasst.
Das Skript `lean_source/mkall.sh` oder `lean_source/mkall.bat` generiert aus den `.lean` Dateien
die `.rst` Dateien für das Dokument in `source` und eine Aufgaben Datei, sowie eine Datei mit Lösungen in `.src`.

Um das Dokument zu bauen, müssen [Sphinx und ReadTheDocs](https://sphinx-rtd-tutorial.readthedocs.io/en/latest/install.html) installiert sein.
Um das Dokument als Latex Dokument zu bauen, muss außerdem [Latex](https://www.tug.org/texlive/) installiert sein.

Die folgenden Dateien werden von Hand gepflegt:

- Die Datei `source/index.rst` sollte einen Eintrag für jedes Kapitel haben.
- Für jedes Kapitel sollte es eine `.rst` Datei in `source` geben. Sie sollte alle Abschnitte enthalten.
- Für jeden Abschnitt sollte es eine `.lean` Datei an der entsprechenden Stelle in `lean_source` geben.
- Jeder Abschnitt sollte eine entsprechende Zeile in `lean_source/mk_all.sh` haben.


## Bauen des Dokuments

Zuerst werden aus den `.lean` Dateien die `.rst` Dateien und die `.lean` Dateien gebaut.

```bash
lean_source/mkall.sh
```

Dann kann das Dokument als Webseite gebaut werden

Linux:
```bash
make html
```

Windows:
```cmd
make.bat html
```

Alternativ kann das Dokument auch als Latex Dokument gebaut werden

Linux:
```bash
make latexpdf
```

Die Build Dateien liegen im `build` Ordner unter den jeweiligen Ordnern `html` und `latex`.