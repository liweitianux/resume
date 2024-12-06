%%
%% Copyright (c) 2018-2024 Weitian LI
%% Copyright (c) 2016 Christophe Roger
%% The LaTeX Project Public License (LPPL) Version 1.3c
%%
%% Resume LaTeX template.
%% Based on
%%     YACC: Another Awesome CV by Christophe Roger
%%     https://github.com/darwiin/yaac-another-awesome-cv
%% which is further based on
%%     Plasmati Graduate CV by Alessandro Plasmati
%%     https://www.latextemplates.com/template/plasmati-graduate-cv
%%

\ProvidesClass{resume}[2024/12/06 v2.6.2 Resume Class]
\LoadClass{article}

%%
%% Class options
%%

\DeclareOption{monochrome}{\def\@monochrome{true}}
\DeclareOption{zh}{\def\@zh{true}}
\ProcessOptions\relax

%%
%% Packages
%%

\RequirePackage[%
  a4paper,%
  margin=1.5cm,%
  includefoot,%
]{geometry}
\RequirePackage{xparse}
\RequirePackage{etoolbox}
\RequirePackage{fontspec}
\RequirePackage{fontawesome5}
\RequirePackage{parskip}  % auto adjust parskip and items skip
\RequirePackage{titlesec}
\RequirePackage{enumitem}
\RequirePackage{setspace}
\RequirePackage{array}
\RequirePackage{multirow}
\RequirePackage{makecell}  % multirowcell
\RequirePackage{longtable}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{tikz}
\RequirePackage[skins]{tcolorbox}  % required by tikz to make the header
\RequirePackage{csquotes}
\RequirePackage{relsize}  % relatively scale the icons
\RequirePackage{keyval}  % key=value style parameters
\ifdef{\@zh}{
  \RequirePackage{xeCJK}
}{}
\RequirePackage{microtype}

%
% Hyperref
%
% Delay the execution of \hypersetup at \begin{document}.
% NOTE: Should be set before hyperref uses it.
\AtBeginDocument{%
  \hypersetup{%
    pdfborder={0 0 0},% No border around links
    pdfauthor={\@name},%
    pdftitle={%
      \ifdef{\@zh}{简历 | \@name}{Resume | \@name}%
      \ifdef{\@tagline}{ | \@tagline}{}%
    },%
    pdfkeywords={\ifdef{\@keywords}{\@keywords}{}},%
  }%
}
\RequirePackage{hyperref}

%%
%% General settings
%%

% Fonts
\defaultfontfeatures{Mapping=tex-text}
\setmainfont{IBM Plex Serif}
\setmonofont{IBM Plex Mono}

% Chinese setup
\ifdef{\@zh}{
  \setCJKmainfont{Noto Serif CJK SC}
  % Redefine '\emph' to bold style
  % Credit: https://tex.stackexchange.com/a/227644
  \let\emph\relax  % there's no \RedeclareTextFontCommand
  \DeclareTextFontCommand{\emph}{\bfseries}
}{}

% Font Awesome icon aliases
\newcommand*{\birthdaySymbol}{\faBirthdayCake}
\newcommand*{\degreeSymbol}{\faGraduationCap}
\newcommand*{\githubSymbol}{\faGithub}
\newcommand*{\homeSymbol}{\faHome}
\newcommand*{\infoSymbol}{\faInfoCircle}
\newcommand*{\mailSymbol}{\faAt}
\newcommand*{\mobileSymbol}{\faPhone}  % \faMobilePhone is too narrow
\newcommand*{\linkedinSymbol}{\faLinkedin}
\newcommand*{\locationSymbol}{\faMapMarker*}
\newcommand*{\phoneSymbol}{\faPhone}
\newcommand*{\universitySymbol}{\faUniversity}

% Color setup
\ifdef{\@monochrome}{
  \definecolor{basecolor}{HTML}{000000}  % black
}{
  \definecolor{basecolor}{HTML}{000066}  % blue
}
\colorlet{linkcolor}{basecolor}
\colorlet{accentcolor}{linkcolor!90}
\colorlet{symbolcolor}{linkcolor!85}

% Date format: yyyy.mm.dd
\newcommand*{\twodigits}[1]{\ifnum#1<10 0\fi\the#1}
\renewcommand*{\today}{%
  \leavevmode\hbox{\the\year.\twodigits\month.\twodigits\day}
}

% Non-numbered pages
\pagestyle{empty}

% Last-page style
\def\ps@lastpage{%
  \def\@oddfoot{\textcolor{gray}{\footnotesize\@fileinfo}\hfil}%
  \def\@evenfoot{\textcolor{gray}{\footnotesize\@fileinfo}\hfil}%
}
\AtEndDocument{\thispagestyle{lastpage}}

% No paragraph indentation
\setlength{\parindent}{0em}

% Line spacing
\ifdef{\@zh}{
  \linespread{1.25}
}{
  \linespread{1.15}
}

% Setup resume sections
\titleformat{\section}{\Large\raggedright}{}{0.2em}{}[\titlerule]
\titlespacing{\section}{0em}{1ex}{1ex}  % <left><before><after>

% Configure list via 'enumitem'
\setlist[itemize,1]{label=\faAngleRight, nosep, leftmargin=2em}
\setlist[description,1]{style=sameline}

% Width of the left column for date ranges
\newlength{\leftcolwidth}
\newlength{\rightcolwidth}
\ifdef{\@zh}{%
  \setlength{\leftcolwidth}{6em}
}{
  \setlength{\leftcolwidth}{8.1em}
}
\setlength{\rightcolwidth}{\dimexpr \textwidth - \leftcolwidth - 4\tabcolsep}

%%
%% Generic commands
%%

\newcommand*{\creativecommons}[2]{%
  \href{https://creativecommons.org/licenses/#1/#2/}%
    {\faCreativeCommons{} \uppercase{#1} #2}%
}

\newcommand*{\githublink}[2]{%
  \href{https://github.com/#1/#2}{\githubSymbol{} #1/#2}%
}

\newcommand*{\link}[2]{\textcolor{linkcolor}{\href{#1}{#2}}}

% The scale step for icons.
% A positive step to enlarge icons, and a negative step to reduce them.
\def\@iconscale{1}
\newcommand*{\iconscale}[1]{\def\@iconscale{#1}}

% Icon: \icon[size]{\faICON}
\NewDocumentCommand{\icon}{om}{
  {\IfValueTF{#1}{#1}{\relsize{\@iconscale}}%
   \makebox[1em][c]{\textcolor{symbolcolor}{#2}}}%
  \hspace{0.2em}\strut%
}

% Test whether the command argument is given and is not empty
% Credit: https://tex.stackexchange.com/a/63233
\ExplSyntaxOn
\DeclareExpandableDocumentCommand{\IfNoValueOrEmptyTF}{mmm}{%
  \IfNoValueTF{#1}{#2}{%
    \tl_if_empty:nTF {#1} {#2} {#3}
  }
}
\ExplSyntaxOff

%%
%% Tags
%%

% Create a tag: \tag{<label>}
\newcommand*{\tag}[1]{%
  \tikz[baseline]
  \node[anchor=base,
        draw=accentcolor!40,
        rounded corners=0.5ex,
        inner xsep=0.8ex,
        inner ysep=0.5ex,
        text height=1.6ex,
        text depth=0.4ex]{#1};
}

\newcommand*{\tags}[1]{%
  \icon{\faTags}
  \foreach \n in {#1}{\tag{\n}\hspace{0.1em}}
}

%%
%% Position and location
%%

\newcommand*{\setposition}[1]{\def\@position{#1}}
\newcommand*{\getposition}{\@position}
\newcommand*{\setlocation}[1]{\def\@location{#1}}
\newcommand*{\getlocation}{\@location}

%%
%% Header
%%

% Render a text with its icon
% Usage: \icontext{<icon>}{<label>}
\newcommand*{\icontext}[2]{%
  \mbox{\icon{#1} #2 \hspace{1em}}%
}

% Render a link with its icon and text
% Usage: \iconlink{<icon>}{<label>}{<text>}
\newcommand*{\iconlink}[3]{%
  \mbox{\icon{#1} \link{#2}{#3} \hspace{1em}}%
}

% Name: \name{<firstname>}{<lastname>}
\newcommand*{\name}[2]{
  \def\@firstname{#1}
  \def\@lastname{#2}
  \def\@name{%
    \ifdef{\@zh}%
      {\@lastname\@firstname}%
      {\textsc{\@firstname} \@lastname}%
  }
}
% Tag line
\newcommand*{\tagline}[1]{\def\@tagline{#1}}
% Keywords
\newcommand*{\keywords}[1]{\def\@keywords{#1}}
% File information
\newcommand*{\fileinfo}[1]{\def\@fileinfo{#1}}

% Photo:
% \photo[
%   shape=<circular|square>,    % default is circular
%   position=<left|right>,      % default is left
% ]{<width>}{<filename>}
\define@key{photo}{shape}{\def\@photo@shape{#1}}
\define@key{photo}{position}{\def\@photo@position{#1}}
\NewDocumentCommand{\photo}{
  O{shape=circular, position=left}
  m m
}{
  \setkeys{photo}{#1}
  \def\@photo@width{#2}
  \def\@photo{%
    \begin{minipage}{\@photo@width}
      \ifdefstring{\@photo@shape}{square}{%
        \tikz\path[fill overzoom image={#3}]
          rectangle (\linewidth, \linewidth);% (suppress blank)
      }{%
        \tikz\path[fill overzoom image={#3}]
          circle[radius=0.5\linewidth];% (suppress blank)
      }%
    \end{minipage}% (suppress blank)
  }
}

% Address
\newcommand*{\address}[1]{\icontext{\locationSymbol}{#1}}
% Birthday
\newcommand*{\birthday}[1]{\icontext{\birthdaySymbol}{#1}}
% Place of birth
\newcommand*{\home}[1]{\icontext{\homeSymbol}{#1}}
% Information
\newcommand*{\info}[1]{\icontext{\infoSymbol}{#1}}
% Mobile phone
\newcommand*{\mobile}[1]{\icontext{\mobileSymbol}{#1}}
% Phone
\newcommand*{\phone}[1]{\icontext{\phoneSymbol}{#1}}
% Degree
\newcommand*{\degree}[1]{\icontext{\degreeSymbol}{#1}}
% University
\newcommand*{\university}[1]{\icontext{\universitySymbol}{#1}}

% LinkedIn: \linkedin{<username>}
\newcommand*{\linkedin}[1]{%
  \iconlink{\linkedinSymbol}%
    {https://www.linkedin.com/in/#1}%
    {linkedin.com/in/#1}%
}
% GitHub: \github{<username>}
\newcommand*{\github}[1]{%
  \iconlink{\githubSymbol}%
    {https://github.com/#1}%
    {\texttt{github.com/#1}}%
}
% Email address
\newcommand*{\email}[1]{%
  \iconlink{\mailSymbol}{mailto:#1}{\texttt{#1}}
}

% Define the profile to show in the header
\newcommand*{\profile}[1]{\def\@profile{#1}}

% Render resume header
\newcommand*{\makeheader}{
  \ifdef{\@photo}{%
    \def\@profile@width{\dimexpr \linewidth - \@photo@width - 1em}
    \ifdefstring{\@photo@position}{right}{}{\@photo\hspace{1em}}%
  }{%
    \def\@profile@width{\linewidth}
  }%
  \begin{minipage}{\@profile@width}
    {\LARGE\bfseries\color{accentcolor} \@name}
    \ifdef{\@tagline}{%
      \medskip \\
      {\large \@tagline}
    }{}
    \medskip \\
    \@profile
  \end{minipage}
  \ifdef{\@photo}{%
    % photo on the right side
    \ifdefstring{\@photo@position}{right}{\hfill\@photo}{}% (suppress blank)
  }{}
}

%%
%% Abstract
%%

\RenewDocumentEnvironment{abstract}{}{
  \phantomsection
  \addcontentsline{toc}{section}{\ifdef{\@zh}{摘要}{Abstract}}
  \ifdef{\@zh}{%
    % Use "\ignorespaces" to remove the beginning space, which becomes a
    % glue between western and CJK characters, to make the indentation
    % correct.
    % Credit: https://tex.stackexchange.com/a/331456
    \onehalfspacing\hspace{2em}\ignorespaces
  }{}%
}{%
  \par
  \medskip
}

%%
%% Sections
%%

% Title
\newcommand*{\sectionTitle}[2]{%
  \section{%
    \texorpdfstring%
      {\color{accentcolor}{\icon{#2} \textbf{#1}}}%
      {#1}%
  }
}

% Extra array column types
% Credit: https://tex.stackexchange.com/a/12712
\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}p{#1}}
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}p{#1}}
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}p{#1}}

% Basic entries listing
\NewDocumentEnvironment{entries}{o}{%
  \IfValueTF{#1}%
    {\begin{tabular}{R{\leftcolwidth} #1 L{\rightcolwidth}}}%
    {\begin{tabular}{R{\leftcolwidth} L{\rightcolwidth}}}%
}{%
  \end{tabular}
}

\NewDocumentCommand{\entry}{m m}{
  #1 & \begin{minipage}[t]{\rightcolwidth} #2 \end{minipage} \\
}

% Separator (empty space) between two entries
\newcommand*{\separator}[1]{%
  \multicolumn{2}{c}{} \\[\dimexpr #1 - 1em]
}

%%
%% Section: competences
%%

% \begin{competences}[width]
\NewDocumentEnvironment{competences}{o}{%
  \IfValueTF{#1}{%
    \begin{tabular}{R{#1} L{\dimexpr \textwidth - #1 - 4\tabcolsep}}
  }{%
    \begin{tabular}{R{\leftcolwidth} L{\rightcolwidth}}
  }
}{%
  \end{tabular}
}

\NewDocumentCommand{\comptence}{m m}{
  \textbf{#1} & #2 \\
}

%%
%% Section: educations
%%

\NewDocumentEnvironment{educations}{}{%
  \begin{tabular}{R{\leftcolwidth} | L{\rightcolwidth}}
}{%
  \end{tabular}
}

% \education
%   {<start-date>}  % #1
%   [<end-date>]    % #2
%   {<school>}      % #3
%   {<department>}  % #4
%   {<major>}       % #5
%   {<degree>}      % #6
\NewDocumentCommand{\education}{m o m m m m}{
  \ifdef{\@zh}{%
    \IfValueTF{#2}{#2}{现在} & \textbf{#3} \textbullet #4 \\*
    #1 & #5 \textbullet #6 \\
  }{%
    \IfValueTF{#2}{#2}{present} & #4, \textbf{#3} \\*
    #1 & #6 in #5 \\
  }
}

%%
%% Section: projects
%%

\NewDocumentEnvironment{projects}{}{%
  \begin{longtable}{R{\leftcolwidth} | L{\rightcolwidth}}
}{%
  \end{longtable}
}

% \project
%   {<start-date>}   % #1
%   [<end-date>]     % #2
%   {<department>}   % #3
%   {<type>}         % #4
%   {<name>}         % #5
%   {<description>}  % #6
%   [<tags>]         % #7
\NewDocumentCommand{\project}{m o m m m m o}{
  \multirowcell{2}[0ex][r]{%
    \IfValueTF{#2}{#2}{\ifdef{\@zh}{现在}{present}} \\ #1%
  }
  & \textbf{#5} \\*
  \ifdef{\@zh}{%
    & #3 \textbullet #4 \\*
  }{%
    & #4, #3 \\*
  }
  & \begin{minipage}[t]{\rightcolwidth} #6 \end{minipage} \\*
  \IfValueT{#7}{%
    & \footnotesize{\tags{#7}} \\
  }
}

%%
%% Section: experiences
%%

\NewDocumentEnvironment{experiences}{}{%
  \begin{longtable}{R{\leftcolwidth} | L{\rightcolwidth}}
}{%
  \end{longtable}
}

% \experience
%   [<start-date>]   % #1
%   {<end-date>}     % #2
%   {<summary>}      % #3
%   [<description>]  % #4
%   [<tags>]         % #5
\NewDocumentCommand{\experience}{o m m o o}{
  #2 & #3 \\*
  \IfValueT{#1}{#1}
  \IfNoValueOrEmptyTF{#4}{}{%
     & \begin{minipage}[t]{\rightcolwidth}
         #4
       \end{minipage} \\*
  }
  \IfValueT{#5}{%
    & \footnotesize{\tags{#5}} \\
  }
}

%%
%% Two-column section
%%

\newcommand*{\twocolumnsection}[2]{
  \begin{minipage}[t]{\dimexpr(\linewidth/2) - 3em}
    #1
  \end{minipage}
  \hfill
  \begin{minipage}[t]{\dimexpr(\linewidth/2) - 3em}
    #2
  \end{minipage}
}

%%
%% Section: skills
%%

\NewDocumentEnvironment{skills}{}{%
  \begin{tabular}{R{\leftcolwidth} L{\rightcolwidth}}
}{%
  \end{tabular}
}

\NewDocumentCommand{\skill}{m m}{
  \textbf{#1} &
    \foreach \x in {1,...,5}{%
      \color{accentcolor!80}{%
        \ifnumgreater{\x}{#2}{\faCircleNotch}{\faCircle}
      }
    } \enspace \\
}

%%
%% Section: referees
%%

\newenvironment{referees}{%
}{%
  \hfill
  \bigskip
}

\newcommand*{\referee}[5]{%
  \hspace{1em}
  \begin{minipage}[t]{\dimexpr(\linewidth/3) - 3em}
    \begin{tabular}{>{}l >{}l}
      \multicolumn{2}{l}{\textbf{#1}}\\
      \multicolumn{2}{l}{\emph{#2}, \textsc{#3}}\\
      \quad \mailSymbol & \href{mailto:#4}{#4} \\
      \quad \phoneSymbol & #5 \\
    \end{tabular}
  \end{minipage}%
}

\endinput
%% EOF
