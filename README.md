My Resume and LaTeX Template
============================

**Weitian LI** `<wt@liwt.net>`

Introduction
------------
This repository holds my [resume](resume-zh+en.pdf) (Chinese and English),
the [resume LaTeX template](resume.cls),
and the [Font Awesome 5 LaTeX style](fontawesome5/fontawesome5.sty).

This template is based on the
[YACC: Another Awesome CV](https://github.com/darwiin/yaac-another-awesome-cv)
by Christophe Roger, which is further based on the
[Plasmati Graduate CV](https://www.latextemplates.com/template/plasmati-graduate-cv)
by Alessandro Plasmati.

Usage
-----
1. Install XeLaTeX, latexmk, GNU Make, and GhostScript packages;
2. Install [Font Awesome 5](#font-awesome-5) and
   other [required fonts](#required-fonts);
3. Replace `resume-zh.tex` and `resume-en.tex` with your versions;
4. Compile to PDFs with a simple `make` :-)

**NOTE**:
The `TEXINPUTS` environment variable is set in the [Makefile](Makefile#L10)
so that XeLaTeX can find the `resume.cls` template and `fontawesome5.sty`
package.  If you don't or can't use this `Makefile`, e.g., on Windows,
then you need to appropriately configure your environment.

**NOTE**:
I use Windows only a bit, so I don't have a guide to use this template on
Windows.  I'm glad to accept suggestions and updates.

Font Awesome 5
--------------
I wrote a simple tool [`make-fontawesome5.py`](fontawesome5/make-fontawesome5.py),
which will download the latest icon list from the
[Font Awesome](https://github.com/FortAwesome/Font-Awesome) project
and then generate the LaTeX style file for using the latest
**Font Awesome 5** fonts (the *free* edition) in LaTeX.

This Python script requires the [`PyYAML`](https://github.com/yaml/pyyaml)
package, which can be installed with `pip3 install --user PyYAML`
or `sudo apt install python3-yaml`.

A pre-generated style file [`fontawesome5.sty`](fontawesome5/fontawesome5.sty)
(matches Font Awesome **v5.13.1**) is also provided.

The Font Awesome fonts are designed by the
[Font Awesome project](https://fontawesome.com/)
and can be obtained from [here](https://fontawesome.com/how-to-use/on-the-desktop).
**NOTE**:
All the following 3 fonts should be installed into the system:
* Font Awesome 5 Free
  (generic icons in regular style, much less than the solid style)
* Font Awesome 5 Free Solid
  (generic icons in solid style)
* Font Awesome 5 Free Brands
  (various brand icons)

i.e., the following 3 OTF files are needed:
* `Font Awesome 5 Free-Regular-400.otf`
* `Font Awesome 5 Free-Solid-900.otf`
* `Font Awesome 5 Brands-Regular-400.otf`

Required Fonts
--------------
Besides the Font Awesome fonts, this template also requires the following
opensource fonts:

* [IBM Plex](https://github.com/IBM/plex) (Serif, Mono)

  Download the `OpenType.zip` archive from the
  [releases](https://github.com/IBM/plex/releases) page,
  and then extract the `IBM-Plex-Serif` and `IBM-Plex-Mono` directories
  and install them.

* [Source Han Serif](https://github.com/adobe-fonts/source-han-serif)

  The OTF font files for *Simplified Chinese* can be downloaded from
  [here](https://github.com/adobe-fonts/source-han-serif/tree/release/OTF/SimplifiedChinese).
  Just download all the weight variants:
  ExtraLight, Light, Regular, Medium, SemiBold, Bold, Heavy.

Of course, you can use the fonts you prefer by modifying the template directly.
However, you may need to tweak the
[column width in the template](resume.cls#L158)
accordingly.

Fonts Installation
------------------
On **Linux** systems, create a directory for each font family under
`~/.local/share/fonts`, then copy the font files (OTF or TTF) over,
then execute `fc-cache -f` to refresh the font cache, done.

Take the *Font Awesome* font family as an example:

1. `mkdir -p ~/.local/share/fonts/FontAwesome`
2. `cp <font-awesome-otf-files> ~/.local/share/fonts/FontAwesome/`
3. `fc-cache -fv`
4. check the fonts correctly installed: `fc-list | grep 'FontAwesome'`

License
-------
* The LaTeX class [`resume.cls`](resume.cls) is distributed under the
  [LaTeX Project Public License (LPPL) Version 1.3c](https://www.latex-project.org/lppl.txt).
* The tool [`make-fontawesome5.py`](fontawesome5/make-fontawesome5.py)
  is distributed under the
  [MIT License](https://opensource.org/licenses/MIT).
* All content files are published under the
  [CC BY 4.0 License](https://creativecommons.org/licenses/by/4.0/).
