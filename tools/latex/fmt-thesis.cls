% fmt-thesis.cls -- LaTeX replica of the official Word template for bachelor
% theses at the Faculty of Materials and Technology (FMT), VSB-TUO,
% academic year 2026/2027 (docs/predpisy/FMT_Sablona_bakalarske_prace_2026_2027.docx).
%
% Every length below was measured from the official template rendered with
% the real Calibri/Cambria fonts. Measured values are noted next to the code
% (positions are from the top-left corner of an A4 page).
%
% The class is driven by tools/latex/template.tex (a pandoc template); thesis
% authors never edit LaTeX directly, they write Markdown in thesis/.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fmt-thesis}[2026/11/04 FMT VSB-TUO bachelor thesis replica]

\LoadClass[12pt,a4paper,oneside]{report}

% ---------------------------------------------------------------------------
% Packages
% ---------------------------------------------------------------------------
\RequirePackage[a4paper,left=25mm,right=25mm,top=25mm,bottom=25mm,
  headheight=1pt,headsep=0pt,footskip=6.8mm]{geometry} % footer baseline 278.8 mm
\RequirePackage[fleqn]{amsmath}
\RequirePackage{amssymb}
\RequirePackage{fontspec}
\RequirePackage{unicode-math}
\RequirePackage[shorthands=off,english,main=czech]{babel}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{tikz}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage{caption}
\RequirePackage{indentfirst}
\RequirePackage{calc}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{longtable}
\RequirePackage{booktabs}
\newcounter{none} % longtable counter for unnumbered tables
\RequirePackage{enumitem}
\RequirePackage{lastpage}
\RequirePackage{etoolbox}

% ---------------------------------------------------------------------------
% Paths (relative to the directory lualatex runs in, i.e. the repo root)
% ---------------------------------------------------------------------------
\providecommand\fmtroot{tools/latex/}
\newcommand\fmt@fontpath{\fmtroot fonts/}
\newcommand\fmt@logopath{\fmtroot logos/}

% ---------------------------------------------------------------------------
% Fonts: Calibri 12 pt body, Cambria Math 10 pt for equations.
% The proprietary fonts live in tools/latex/fonts/. If they are missing, the
% metric-compatible Carlito and STIX Two Math are used (page breaks stay the
% same for Carlito) and a warning is printed.
% ---------------------------------------------------------------------------
\newif\iffmt@realfonts
\IfFileExists{\fmt@fontpath calibri.ttf}{\fmt@realfontstrue}{\fmt@realfontsfalse}
\iffmt@realfonts
  \setmainfont{calibri.ttf}[
    Path=\fmt@fontpath,
    BoldFont=calibrib.ttf,
    ItalicFont=calibrii.ttf,
    BoldItalicFont=calibriz.ttf]
  \setsansfont{calibri.ttf}[
    Path=\fmt@fontpath,
    BoldFont=calibrib.ttf,
    ItalicFont=calibrii.ttf,
    BoldItalicFont=calibriz.ttf]
  \setmathfont{cambria.ttc}[Path=\fmt@fontpath, FontIndex=1, Scale=0.8333]
\else
  \ClassWarningNoLine{fmt-thesis}{Calibri/Cambria not found in
    \fmt@fontpath; using Carlito and STIX Two Math. Do NOT submit this PDF}
  \IfFontExistsTF{Carlito}{\setmainfont{Carlito}\setsansfont{Carlito}}{}
  \IfFontExistsTF{STIX Two Math}{\setmathfont{STIX Two Math}[Scale=0.8333]}{}
\fi

% ---------------------------------------------------------------------------
% Colours (VSB-TUO visual style, Pantone 3272 C)
% ---------------------------------------------------------------------------
\definecolor{fmtteal}{HTML}{00A499}
\definecolor{fmtlink}{HTML}{0563C1}

% ---------------------------------------------------------------------------
% Body text: Calibri 12 pt, line spacing "multiple 1.2" = 17.55 pt pitch,
% justified, first-line indent 8 mm, no space between paragraphs,
% no hyphenation (the template has hyphenation switched off).
% ---------------------------------------------------------------------------
\renewcommand\normalsize{\fontsize{12}{17.55}\selectfont
  \abovedisplayskip 6pt \belowdisplayskip 6pt
  \abovedisplayshortskip 6pt \belowdisplayshortskip 6pt}
\newcommand\fmt@elevenpt{\fontsize{11}{16.1}\selectfont}
\normalsize
\setlength\parindent{8mm}
\setlength\parskip{0pt}
\setlength\mathindent{2.1mm}           % equations start at 27.1 mm
\hyphenpenalty=10000
\exhyphenpenalty=10000
\setlength\emergencystretch{3em}
\tolerance=2000
\raggedbottom
\setlength\topskip{12pt}

% Equation numbers: Calibri 11 pt "(1)", continuous numbering, right edge
% 2 mm inside the margin (183.0 mm).
\counterwithout{equation}{chapter}
\counterwithout{figure}{chapter}
\counterwithout{table}{chapter}
\def\tagform@#1{\maketag@@@{\fmt@elevenpt(\ignorespaces#1\unskip\@@italiccorr)\kern2mm}}

% ---------------------------------------------------------------------------
% Names
% ---------------------------------------------------------------------------
\addto\captionsczech{%
  \renewcommand\contentsname{Obsah}%
  \renewcommand\listfigurename{Seznam obrázků}%
  \renewcommand\listtablename{Seznam tabulek}%
  \renewcommand\bibname{Použitá literatura}%
  \renewcommand\figurename{Obr.}%
  \renewcommand\tablename{Tab.}}

% ---------------------------------------------------------------------------
% Headings
%   H1 Calibri bold 16 pt teal, number box 7.6 mm, each chapter on a new page,
%      baseline 36.95 mm on a fresh page, first text baseline 11.1 mm below.
%   H2 bold 14 pt teal, number box 10.16 mm, 10.3 mm above / 7.2 mm below
%      (baseline-to-baseline).
%   H3 bold 12 pt teal, number box 12.7 mm.
% ---------------------------------------------------------------------------
\setcounter{secnumdepth}{2}
\setcounter{tocdepth}{2}
\titleformat{\chapter}[hang]
  {\fontsize{16}{19.5}\selectfont\bfseries\color{fmtteal}}
  {\makebox[7.6mm][l]{\thechapter}}{0pt}{}
\titleformat{name=\chapter,numberless}[hang]
  {\fontsize{16}{19.5}\selectfont\bfseries\color{fmtteal}}{}{0pt}{}
\titlespacing*{\chapter}{0pt}{2.46pt}{14.1pt}
\titleformat{\section}[hang]
  {\fontsize{14}{17}\selectfont\bfseries\color{fmtteal}}
  {\makebox[10.16mm][l]{\thesection}}{0pt}{}
\titlespacing*{\section}{0pt}{12.37pt plus 2pt minus 1pt}{3.02pt}
\titleformat{\subsection}[hang]
  {\fontsize{12}{14.6}\selectfont\bfseries\color{fmtteal}}
  {\makebox[12.7mm][l]{\thesubsection}}{0pt}{}
\titlespacing*{\subsection}{0pt}{7pt plus 2pt minus 1pt}{2pt}
\titleformat{\subsubsection}[hang]
  {\normalsize\bfseries\color{fmtteal}}{}{0pt}{}
\titlespacing*{\subsubsection}{0pt}{6pt}{0pt}

% Unnumbered heading in chapter style that does not start a new page
% (used for "Seznam obrázků", which shares a page with "Seznam tabulek").
\newcommand\fmt@inlineheading[1]{%
  \par\addvspace{6.5mm}%
  {\noindent\fontsize{16}{19.5}\selectfont\bfseries\color{fmtteal}#1\par}%
  \vspace{13.68pt}}

% ---------------------------------------------------------------------------
% Page styles: VSB-FMT logo in the header (all pages except the title page
% and the assignment), centred page number from "Obsah" onwards. The template
% centres the number in a paragraph with an 8 mm first-line indent, which
% shifts it 4 mm right of the text centre; the replica keeps that.
% ---------------------------------------------------------------------------
\newcommand\fmt@headerlogo{%
  \begin{tikzpicture}[remember picture,overlay]
    \node[anchor=north west,inner sep=0pt]
      at ([xshift=25mm,yshift=-9.4mm]current page.north west)
      {\includegraphics[width=64.9mm]{\fmt@logopath vsb-fmt-logo.png}};
  \end{tikzpicture}}
\renewcommand\headrulewidth{0pt}
\fancypagestyle{fmtmain}{%
  \fancyhf{}%
  \fancyhead[L]{\fmt@headerlogo}%
  \fancyfoot[C]{\hspace*{8mm}\fmt@elevenpt\thepage}}
\fancypagestyle{fmtfront}{%
  \fancyhf{}%
  \fancyhead[L]{\fmt@headerlogo}}
\fancypagestyle{fmtblank}{\fancyhf{}}
\fancypagestyle{plain}{%
  \fancyhf{}%
  \fancyhead[L]{\fmt@headerlogo}%
  \fancyfoot[C]{\hspace*{8mm}\fmt@elevenpt\thepage}}
\pagestyle{fmtmain}

% ---------------------------------------------------------------------------
% Captions: Calibri 11 pt italic, label bold italic ("Obr. 1", "Tab. 1"),
% single line spacing, 6 pt before and after. Figure captions below the
% figure, table captions above the table.
% ---------------------------------------------------------------------------
\DeclareCaptionFont{fmtcaption}{\fontsize{11}{13.4}\selectfont}
% Label and text are separated by two spaces in the template (1.74 mm).
\DeclareCaptionLabelSeparator{fmt}{\hspace{1.74mm}}
\captionsetup{font={fmtcaption,it},labelfont={bf,it},labelsep=fmt,
  skip=6pt,singlelinecheck=false}
\captionsetup[table]{justification=raggedright,position=above,skip=8.3pt}
% With \DocumentMetadata the kernel (latex-lab) redefines \caption for floats
% at the end of \begin{document}, so the caption package settings above only
% reach longtable captions. Float captions get the same look here.
\AddToHook{begindocument/end}{%
  \long\def\@makecaption#1#2{%
    \vskip6pt
    {\fontsize{11}{13.4}\selectfont\itshape
     \ifx\@captype\fmt@figuretype\centering\else\raggedright\fi
     \textbf{#1}\hspace{1.74mm}#2\par}%
    \vskip\fmt@captionafter}}
% A figure caption is the last thing in its float, so the 6 pt after it and
% \intextsep below the float would add up; the template has only the 6 pt.
\newcommand\fmt@captionafter{%
  \ifx\@captype\fmt@figuretype\dimexpr6pt-\intextsep-2.2pt\relax\else6pt\fi}
\def\fmt@figuretype{figure}
\setlength\intextsep{12pt}
\setlength\textfloatsep{12pt}

% ---------------------------------------------------------------------------
% Tables: the template's "Mřížka tabulky" grid over the full text width,
% outer border 1.5 pt, inner lines 0.75 pt, the header row closed by a
% 1.5 pt line, Word's default cell margins 1.9 mm. tools/pandoc/fmt.lua
% rewrites pandoc's booktabs longtables into this form.
% ---------------------------------------------------------------------------
\newlength\fmttableouterrule
\setlength\fmttableouterrule{1.5pt}
\newcommand\fmttablesetup{%
  \setlength\arrayrulewidth{0.75pt}%
  \setlength\tabcolsep{1.9mm}%
  \renewcommand\arraystretch{0.92}%
  \setlength\LTleft{0pt}\setlength\LTright{\fill}%
  \setlength\LTcapwidth{\linewidth}%
  \setlength\LTpre{\fmt@ltpre}\setlength\LTpost{\fmt@ltpost}}
\newcommand\fmt@ltpre{12pt}
\newcommand\fmt@ltpost{6.9pt}
\def\fmttablethick{\noalign{\hrule height\fmttableouterrule}}
\def\fmttablethin{\noalign{\hrule height\arrayrulewidth}}

% ---------------------------------------------------------------------------
% Table of contents: Calibri 11 pt, 7.53 mm pitch, dot leaders.
%   level 1: number at 8.0 mm, text at 19.4 mm (from the left margin)
%   level 2: number at 11.9 mm, text at 25.4 mm
%   level 3: number at 15.8 mm, text at 29.6 mm
% ---------------------------------------------------------------------------
\newcommand\fmt@tocfont{\fontsize{11}{16.1}\selectfont}
\newcommand\fmt@tocfill{\titlerule*[0.252em]{.}\nobreak\thecontentspage}
\titlecontents{chapter}[19.4mm]{\fmt@tocfont\addvspace{0pt}}
  {\contentslabel{11.4mm}}{\hspace*{-11.4mm}}{\fmt@tocfill}[\vspace{5.33pt}]
\titlecontents{section}[25.4mm]{\fmt@tocfont}
  {\contentslabel{13.5mm}}{\hspace*{-13.5mm}}{\fmt@tocfill}[\vspace{5.33pt}]
\titlecontents{subsection}[29.6mm]{\fmt@tocfont}
  {\contentslabel{13.8mm}}{\hspace*{-13.8mm}}{\fmt@tocfill}[\vspace{5.33pt}]
\titlecontents{figure}[8mm]{\fmt@tocfont}
  {\textbf{\figurename~\thecontentslabel}\hspace{1.74mm}}{}{\fmt@tocfill}[\vspace{5.33pt}]
\titlecontents{table}[8mm]{\fmt@tocfont}
  {\textbf{\tablename~\thecontentslabel}\hspace{1.74mm}}{}{\fmt@tocfill}[\vspace{5.33pt}]
\contentsmargin{0pt}

% ---------------------------------------------------------------------------
% Lists
% ---------------------------------------------------------------------------
\setlist{noitemsep,topsep=3pt,leftmargin=8mm}
\setlist[itemize,1]{label=\textbullet}

% ---------------------------------------------------------------------------
% "Kde:" block under an equation: Calibri 11 pt, one symbol per line in the
% form "symbol – meaning [unit]".
% ---------------------------------------------------------------------------
\newenvironment{fmtkde}
  {\par\addvspace{6pt}\noindent\fmt@elevenpt Kde:\par
   \begingroup\setlength\parindent{0pt}\fmt@elevenpt}
  {\par\endgroup\addvspace{6pt}}

% ---------------------------------------------------------------------------
% Bibliography (pandoc citeproc, ISO 690 numeric with brackets):
% label "[1]" at the margin, text hanging at 7.6 mm.
% ---------------------------------------------------------------------------
\newlength{\cslhangindent}
\setlength{\cslhangindent}{7.6mm}
\newlength{\csllabelwidth}
\setlength{\csllabelwidth}{7.6mm}
\newenvironment{CSLReferences}[2]
 {\begin{list}{}{%
    \setlength{\itemindent}{0pt}%
    \setlength{\leftmargin}{0pt}%
    \setlength{\parsep}{0pt}%
    \setlength{\itemsep}{#2\baselineskip}}%
  \raggedright}
 {\end{list}}
\newcommand{\CSLBlock}[1]{\hfill\break\parbox[t]{\linewidth}{\strut\ignorespaces#1\strut}}
\newcommand{\CSLLeftMargin}[1]{\parbox[t]{\csllabelwidth}{\strut#1\strut}}
\newcommand{\CSLRightInline}[1]{\parbox[t]{\linewidth - \csllabelwidth}{\strut#1\strut}}
\newcommand{\CSLIndent}[1]{\hspace{\cslhangindent}#1}

% ---------------------------------------------------------------------------
% Metadata (filled by the pandoc template)
% ---------------------------------------------------------------------------
\newcommand\fmt@def[2]{\expandafter\newcommand\csname fmt@#1\endcsname{#2}%
  \expandafter\newcommand\csname fmtset#1\endcsname[1]{%
    \expandafter\renewcommand\csname fmt@#1\endcsname{##1}}}
\fmt@def{titlecs}{Název bakalářské práce}
\fmt@def{titleen}{Title of bachelor's thesis}
\fmt@def{author}{Jméno a příjmení}
\fmt@def{supervisor}{Jméno a příjmení, tituly}
\fmt@def{program}{Označení a název studijního programu}
\fmt@def{academicyear}{}
\fmt@def{pagecount}{\pageref{LastPage}}
\fmt@def{place}{Ostrava}
\fmt@def{date}{datum odevzdání}
\fmt@def{assignment}{}
\fmt@def{acknowledgements}{}
\fmt@def{abstractcs}{}
\fmt@def{keywordscs}{}
\fmt@def{abstracten}{}
\fmt@def{keywordsen}{}

% Absolute placement helper: #1 x, #2 y (from the page's top-left corner),
% #3 anchor, #4 content.
\newcommand\fmt@at[4]{%
  \begin{tikzpicture}[remember picture,overlay]
    \node[anchor=#3,inner sep=0pt,outer sep=0pt]
      at ([xshift=#1,yshift=-#2]current page.north west) {#4};
  \end{tikzpicture}}

% ---------------------------------------------------------------------------
% Title page (page 1 of the template)
% ---------------------------------------------------------------------------
\newcommand\fmt@titlepage{%
  \thispagestyle{fmtblank}%
  \null
  % faculty logo, 118.8 mm wide, centred on the page, top edge at 24.9 mm
  \fmt@at{105mm}{24.9mm}{north}{%
    \includegraphics[width=118.8mm]{\fmt@logopath vsb-fmt-logo.png}}%
  % Czech title: 22 pt bold teal, centred, first baseline 86.04 mm,
  % then an empty 11 pt line, English title 22 pt teal, "Bakalářská práce" 20 pt
  \fmt@at{105mm}{86.04mm}{base}{%
    \parbox[t]{160mm}{\centering
      \fontsize{22}{32.2}\selectfont\addfontfeatures{LetterSpace=1.14}%
      \leavevmode{\bfseries\color{fmtteal}\fmt@titlecs}\par
      \vspace{16.1pt}%
      \leavevmode{\color{fmtteal}\fmt@titleen}\par
      \vspace{0.33mm}%
      \fontsize{20}{29.3}\selectfont\addfontfeatures{LetterSpace=1.25}%
      Bakalářská práce\par}}%
  % author and supervisor, 18 pt, label bold
  \fmt@at{25mm}{175.19mm}{base west}{%
    \fontsize{18}{26}\selectfont\addfontfeatures{LetterSpace=1.39}%
    \textbf{Autor práce}: \fmt@author}%
  \fmt@at{25mm}{186.95mm}{base west}{%
    \fontsize{18}{26}\selectfont\addfontfeatures{LetterSpace=1.39}%
    \textbf{Vedoucí bakalářské práce}: \fmt@supervisor}%
  % place and date
  \fmt@at{25mm}{257.09mm}{base west}{%
    \fontsize{18}{26}\selectfont\addfontfeatures{LetterSpace=1.39}%
    \fmt@place, \fmt@date}%
  % decorative stripes, 84.5 x 34.6 mm, right edge at 184.1 mm
  \fmt@at{99.6mm}{222.5mm}{north west}{%
    \includegraphics[height=84.5mm,angle=-90]{\fmt@logopath stripes-vertical.png}}%
  \clearpage}

% Page 2: bibliographic record at the bottom, stripes in the top right corner
\newcommand\fmt@bibrecordpage{%
  \thispagestyle{fmtfront}%
  \null
  \fmt@at{150.5mm}{31.4mm}{north west}{%
    \includegraphics[width=34.6mm]{\fmt@logopath stripes-vertical.png}}%
  \fmt@at{25mm}{266.77mm}{base west}{%
    \parbox[b]{160mm}{\raggedright
      \textbf{Bibliografický záznam}\par
      Autor: \fmt@author\par
      Název práce: \fmt@titlecs\par
      Studijní program: \fmt@program\par
      Vedoucí bakalářské práce: \fmt@supervisor\par
      Akademický rok: \fmt@academicyear\par
      Počet stran: \fmt@pagecount}}%
  \clearpage}

% Page 3: the assignment from IS EDISON (unsigned PDF), without header
\newcommand\fmt@assignmentpage{%
  \ifx\fmt@assignment\@empty
    \thispagestyle{fmtblank}%
    \null
    \fmt@at{105mm}{34mm}{base}{%
      \fontsize{12}{14}\selectfont\bfseries\color{fmtteal}%
      Zde vložte Zadání závěrečné práce bez podpisů.}%
    \clearpage
  \else
    \includepdf[pages=-,pagecommand={\thispagestyle{fmtblank}}]{\fmt@assignment}%
  \fi}

% Page 4: acknowledgements, heading baseline at 236.98 mm
\newcommand\fmt@acknowledgementspage{%
  \ifx\fmt@acknowledgements\@empty\else
    \thispagestyle{fmtfront}%
    \null
    \fmt@at{25mm}{236.98mm}{base west}{%
      \parbox[t]{160mm}{%
        \noindent{\fontsize{16}{19.5}\selectfont\bfseries\color{fmtteal}Poděkování}\par
        \vspace{11.74pt}%
        \setlength\parindent{0pt}\fmt@acknowledgements\par}}%
    \clearpage
  \fi}

% Page 5: abstract and keywords (Czech + English) on one page
\newcommand\fmt@frontheading[1]{%
  {\noindent\fontsize{16}{19.5}\selectfont\bfseries\color{fmtteal}#1\par}%
  \vspace{14.1pt}}
\newcommand\fmt@abstractpage{%
  \thispagestyle{fmtfront}%
  \vspace*{2.46pt}%
  \fmt@frontheading{Abstrakt}%
  \fmt@abstractcs\par
  \vspace{12pt}%
  \noindent\textbf{Klíčová slova}: \fmt@keywordscs\par
  \vspace{31.6pt}%
  \fmt@frontheading{Abstract}%
  {\selectlanguage{english}\fmt@abstracten\par
  \vspace{12pt}%
  \noindent\textbf{Keywords}: \fmt@keywordsen\par}%
  \clearpage}

% ---------------------------------------------------------------------------
% Abbreviations and symbols: grid table Zkratka/Symbol | Jednotka | Popis
% (column widths 32.0 / 22.2 / 105.8 mm). Use as
%   \begin{fmtsymbols} FMT & -- & Fakulta ... \\ \end{fmtsymbols}
% ---------------------------------------------------------------------------
\newenvironment{fmtsymbols}
  {\chapter*{Seznam použitých zkratek a symbolů}%
   \noindent\setlength\tabcolsep{1.9mm}\renewcommand\arraystretch{0.95}%
   \def\LTcaptype{none}% unnumbered: must not consume "Tab. 1"
   \begin{longtable}{|>{\raggedright\arraybackslash}p{32mm-2\tabcolsep-0.4pt}
     |>{\raggedright\arraybackslash}p{22.2mm-2\tabcolsep-0.4pt}
     |>{\raggedright\arraybackslash}p{105.8mm-2\tabcolsep-0.8pt}|}
   \hline
   \centering\textbf{Zkratka/ Symbol} & \centering\textbf{Jednotka} &
   \centering\arraybackslash\textbf{Popis} \\ \hline \endhead}
  {\end{longtable}}

% ---------------------------------------------------------------------------
% Front matter in the order required by the FMT rules, section II:
% title page, bibliographic record, assignment, acknowledgements, abstract,
% contents (page 1), abbreviations, list of tables, list of figures.
% ---------------------------------------------------------------------------
\newcommand\fmtfrontmatter{%
  \pagenumbering{gobble}%
  \fmt@titlepage
  \fmt@bibrecordpage
  \fmt@assignmentpage
  \fmt@acknowledgementspage
  \fmt@abstractpage
  \pagenumbering{arabic}%
  \pagestyle{fmtmain}%
  \tableofcontents
  \clearpage}

% A list is printed only when the previous run wrote at least one entry
% into \jobname.lot / \jobname.lof (FMT: lists only if the thesis has
% tables / figures).
\newif\iffmt@haslot
\newif\iffmt@haslof
\ExplSyntaxOn
\cs_new_protected:Npn \fmt_check_list:nN #1#2
  {
    \bool_set_false:N \l_tmpa_bool
    \file_if_exist:nT { \c_sys_jobname_str . #1 }
      {
        \file_get:nnN { \c_sys_jobname_str . #1 } { } \l_tmpa_tl
        \tl_if_in:NnT \l_tmpa_tl { \contentsline } { \bool_set_true:N \l_tmpa_bool }
      }
    \bool_if:NTF \l_tmpa_bool { \use:c { fmt@has#1true } } { \use:c { fmt@has#1false } }
  }
\AtBeginDocument { \fmt_check_list:nN { lot } \c_true_bool \fmt_check_list:nN { lof } \c_true_bool }
\ExplSyntaxOff
% A hidden list still has to open its \jobname.lo? file for writing,
% otherwise a clean build never records entries and never shows the list.
\newcommand\fmt@hiddentoc[1]{\setbox\z@\vbox{\@starttoc{#1}}}
% Every chapter writes \addvspace{10pt} into the lists; the template's lists
% have no gaps between chapters.
\newcommand\fmt@list[1]{\begingroup\let\addvspace\@gobble
  \vspace*{\fmt@listshift}\@starttoc{#1}\endgroup}
\newcommand\fmt@listshift{-1.45pt}
\newcommand\fmtlists{%
  \iffmt@haslot
    \chapter*{\listtablename}%
    \fmt@list{lot}%
    \iffmt@haslof
      \fmt@inlineheading{\listfigurename}%
      \fmt@list{lof}%
    \else
      \fmt@hiddentoc{lof}%
    \fi
  \else
    \fmt@hiddentoc{lot}%
    \iffmt@haslof
      \chapter*{\listfigurename}%
      \fmt@list{lof}%
    \else
      \fmt@hiddentoc{lof}%
    \fi
  \fi}

% Contents heading uses the chapter style; report's \tableofcontents calls
% \chapter*, which is what we want.
\renewcommand\tableofcontents{%
  \chapter*{\contentsname}%
  \vspace*{-3.8pt}%
  \@starttoc{toc}}

\RequirePackage{pdfpages}
\RequirePackage{hyperref}
\hypersetup{colorlinks=true,linkcolor=black,citecolor=black,
  urlcolor=fmtlink,bookmarksnumbered=true}
\endinput
