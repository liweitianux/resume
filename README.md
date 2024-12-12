My Resume and LaTeX Template
============================

Introduction
------------
This repository holds my [resume](resume-zh+en.pdf) (Chinese and English) and
the [LaTeX template](resume.cls).

The LaTeX template is based on the
[YACC: Another Awesome CV](https://github.com/darwiin/yaac-another-awesome-cv)
by Christophe Roger, which is further based on the
[Plasmati Graduate CV](https://www.latextemplates.com/template/plasmati-graduate-cv)
by Alessandro Plasmati.

This template is also available on
[Overleaf](https://www.overleaf.com/latex/templates/simple-resume-template-for-new-graduate-ying-jie-sheng-jian-li-mo-ban/hxrntvmmvnqt).
Welcome to try it and report back.

Usage
-----
* Linux

  1. Install XeLaTeX, latexmk, GNU Make, and GhostScript packages;
  2. Install the [required fonts](#required-fonts);
  3. Replace `resume-zh.tex` and `resume-en.tex` with your versions;
  4. Compile to PDFs with a simple `make` :-)

* Windows

  1. Install [MiKTeX](https://miktex.org/);
  2. Install the [required fonts](#required-fonts);
  3. Replace `resume-zh.tex` and `resume-en.tex` with your versions;
  4. Open `resume-*.tex` in TeXWorks, choose `XeLaTeX` to compile,
     and confirm the prompts to install the missing packages along
     the run.

* Docker or Podman

  Just run `make docker` or `make podman`.

Font Awesome 5
--------------
**NOTE**:
The [fontawesome5 package](https://www.ctan.org/pkg/fontawesome5) from CTAN
is used, which is more advanced and bundles with the font files.

The original [fontawesome5](fontawesome5/) contents are now obsolete but kept
for reference.

<blockquote>

I wrote a simple tool [`make-fontawesome5.py`](fontawesome5/make-fontawesome5.py),
which will download the latest icon list from the
[Font Awesome](https://github.com/FortAwesome/Font-Awesome) project
and then generate the LaTeX style file for using the latest
**Font Awesome 5** fonts (the *free* edition) in LaTeX.

This Python script requires the [`PyYAML`](https://github.com/yaml/pyyaml)
package, which can be installed with `pip3 install --user PyYAML`
or `sudo apt install python3-yaml`.

A pre-generated style file [`fontawesome5.sty`](fontawesome5/fontawesome5.sty)
(matches Font Awesome **v5.15.4**) is also provided.

The Font Awesome fonts are designed by the
[Font Awesome project](https://fontawesome.com/)
and can be obtained from [here](https://fontawesome.com/v5/download).
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

</blockquote>

### Installation

* Linux (Debian 12/bookworm)

  - Method 1: Install the `texlive-fonts-extra` package, but it pulls off
    lots of fonts and costs ~1.6GB disk space!
  - Method 2: Manually install the `fontawesome5` package to `~/texmf`
    with the `tlmgr` (TeX Live Manager) tool:
    (1) initialize the user tree: `tlmgr --usermode init-usertree`;
    (2) install the package: `tlmgr --usermode install fontawesome5`.

* Windows (MiKTeX 22.10)

  MiKTeX will auto prompt for the missing package, so just confirm to
  install it.

Required Fonts
--------------
Besides the Font Awesome fonts, this template also requires the following
opensource fonts:

* [IBM Plex](https://github.com/IBM/plex) (Serif, Mono)

  Download the `OpenType.zip` archive from the
  [releases](https://github.com/IBM/plex/releases) page,
  and then extract the `IBM-Plex-Serif` and `IBM-Plex-Mono` directories
  and install them.

* [Noto Serif CJK](https://github.com/notofonts/noto-cjk)

  Download the `NotoSerifCJKsc.zip` archive
  (Language Specific OTFs Simplified Chinese) from the
  [releases](https://github.com/notofonts/noto-cjk/releases) page,
  and then install all of them.

On Debian Linux, simply do `apt install fonts-ibm-plex fonts-noto-cjk`.

Of course, you can use the fonts you prefer by modifying the template directly.
However, you may need to tweak the
[column width `\leftcolwidth` in the template](resume.cls)
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
