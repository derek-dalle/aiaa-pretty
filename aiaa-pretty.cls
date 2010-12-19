%%
%% This is file `aiaa-pretty.cls'.  It is based off of aiaa-tc.cls, which was
%% written by Bil Kleb, Bill Wood, and Erich Knauseberger.
%%
%% Editing this file is perfectly permitted by the distributing author, Derek
%% Dalle, but changing the name is recommended before making any major changes.
%%
%% -----------------------------------------------------------------------------
%% IMPORTANT USE GUIDELINES:
%% For best results, use the new commands \AIAAauthor and \AIAAabstract.
%% Although it is possible to mimic all of the formatting options provided by
%% this file using the old commands (\author, \begin{abstract}, \end{abstract}),
%% using these new commands will allow you to switch between the various formats
%% by only changing one word in the first line of your .tex file.  The one word
%% is the option passed to this class.  For example switching beween the
%% two-column format, which shows approximately how your article will look in
%% print to the submission format according to AIAA guidelines means only making
%% the following change.
%%
%%    \documentclass[journal]{aiaa-dd}  -->  \documentclass[submit]{aiaa-dd}
%%
%% Below is an example that shows how to use the \AIAAauthor and \AIAAabstract
%% commands and how this relates to the standard LaTeX information.
%%
%% OLD:
%%   \author{Derek J. Dalle and Sean M. Torrez}
%%   \maketitle 
%%   \begin{abstract}
%%     ... text ... (formatting allowed)
%%   \end{abstract}
%%
%% NEW (recommended):
%%   \AIAAauthor[Dalle and Torrez]{Derek J. Dalle and Sean M. Torrez}
%%   \AIAAabstract{
%%     ... text ... (formatting still allowed)
%%   }
%%   \maketitle
%%
%% -----------------------------------------------------------------------------
%%
%% 
%% This provides a template for AIAA papers.
%% 
%% This software is released under the terms of the LaTeX Project Public
%% License.  Copyright (C) 2004 by Bil Kleb, Bill Wood, and Erich Knausenberger.
%% 
%% Description: LaTeX package for AIAA papers.
%% Keywords: LaTeX, class, AIAA, BibTeX, bibliographic-style
%% Author (aiaa-pretty.cls): Derek Dalle
%% Author (aiaa-tc.cls): Bil Kleb, Bill Wood, Erich Knausenberger
%% Maintainer: Derek Dalle
%% Version: 1.0 <19 Dec 2010>
%%
%% There are two installation options.
%%
%%   1. Put this file in the same directory as your .tex file, or near it, and 
%%      specify the relative path to this file from the .tex folder in the 
%%      \documentclass line.  For example, if this file is in a directory one
%%      level higher than your .tex file, you should use
%%      \documentclass{../aiaa-dd}.
%%
%%   2. Alternately, you could put this file somewhere in your TeX distribution
%%      directory.  If 'texmf' is the path to your main TeX distribution folder,
%%      then a good recommendation is putting this file in 
%%      'texmf/tex/latex/aiaa/'.  This is the same directory that would contain
%%      the aiaa-tc.cls file if it is installed.
%%
%%  'aiaa-pretty.cls' - A LaTeX class to create AIAA technical papers.
%%
%%  The basic approach is to load the LaTeX article class and various
%%  standard LaTeX packages, and then make modifications and extensions to
%%  conform to AIAA's guidelines.
%%
%%  To use, simply select this class file in your LaTeX document.  For example,
%%
%%    \documentclass{aiaa-pretty}
%%
%%  Class options:
%%
%%   conference - used for hand carrying a paper to a 'loose papers'
%%                conference.  It adds the conference name to the
%%                top of the first page, paper number to the bottom
%%                of each page, and a copyright notice on the bottom
%%                of the first.
%%
%%   submit     - produces output typically required for journal submission,
%%                i.e., 12pt font and 'double spacing'.
%%
%%   journal    - produces a style that attempts to replicate a typical
%%                style found in an AIAA journal
%%
%%  Additional options specified in the \documentclass line will be passed 
%%  to the article class.
%%
%%  Class-specific commands:
%%
%%   \thanksibid{} - Reuses \thanks footnote symbol from previous
%%                   author specified by position in \author command.
%%                   For example, `someone\thanksibid{2}' will reuse the
%%                   footnote symbol from the second author for 'someone'
%%                   without producing a repeated footnote at the bottom.
%%
%%   \AIAAauthor[short info]{full names, etc.}
%%                      - New method for specifying author information.
%%                        The old \author{names, etc.} is still functional,
%%                        but the headers for the 'journal' option will not
%%                        contain the authors' last names.
%%
%%   \AIAAabstract{text of abstract}
%%                      - New method of entering abstract.  The old
%%                        \begin{abstract}... text ... \end{abstract} method
%%                        is still functional, but the abstract will be in
%%                        one column when using the 'journal' option, which
%%                        match the AIAA journal formatting.  Make sure to
%%                        use this command BEFORE the \maketitle line.
%%
%%   \AIAApapernumber{} - Inserts number of AIAA paper.  For use with the
%%                        'conference' option.
%%
%%    \AIAAconference{} - Inserts the name of the conference.  For use with
%%                        the 'conference' option.
%%
%%       \AIAAjournal{} - Inserts the name of the journal.  For use with the
%%                        'journal' option.
%%
%%     \AIAAcopyright{} - Inserts copyright info on bottom of first page
%%                        when used with 'conference' option.  Must be filled
%%                        with one of the various copyright types:
%%                          \AIAAcopyrightA{year},
%%                          \AIAAcopyrightB{year}{holder},
%%                          \AIAAcopyrightC,
%%                          \AIAAcopyrightD{year}, or
%%                          \AIAAcopyrightDAPL{year}.
%%
%%   \AIAAsubmitinfo{} - Footer information used by 'submit' option.
%%
%%

% This prevents the compiler from running on old versions of LaTeX.
\NeedsTeXFormat{LaTeX2e}

% This command gives the name of the class.
\ProvidesClass{../../tex/aiaa-pretty}[2010/01/10 v1.0 AIAA paper]

% These two lines define three new logical variables.
% The names of the logical variables are \@aiaa@conference, \@aiaa@submit, and \@aiaa@journal.
% The default values are false.
\newif\if@aiaa@conference
\newif\if@aiaa@submit
\newif\if@aiaa@journal

% This section is for processing options given to the aiaa-dd class.
% The first two lines work by setting the logical variables defined above accordingly.
\DeclareOption{conference}{\@aiaa@conferencetrue}
\DeclareOption{submit}{\@aiaa@submittrue}
\DeclareOption{journal}{\@aiaa@journaltrue}
% This passes any other options on to the article class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}%
                \typeout{Unknown option: passing ``\CurrentOption"
                         option on to the standard LaTeX article class.}}
% This command appears to tell LaTeX to simply process the class options.
\ProcessOptions

% This control structure calls the basic LaTeX article.cls class.
% The base font size should be 10pt unless using the submit option.
\if@aiaa@submit
 \LoadClass[letterpaper,12pt]{article}
\else\if@aiaa@journal
 \LoadClass[letterpaper,10pt,twoside]{article}
\else
 \LoadClass[letterpaper,10pt]{article}
\fi\fi

% Change the base font size for journal papers.
% This is bit of a mystery, but see 
% texmf/tex/latex/base/size10.clo for comparison.
% This is not perfectly calibrated to AIAA journal typesetting.
% In the text produced using these options, the characters are
% too small, and the spacing between lines is too big.  Note
% however that the secondary text sizes seem to match those
% produced by size10.clo.
\if@aiaa@journal
  \renewcommand\normalsize{%
   \@setfontsize\normalsize\@ixpt\@xipt%
   \abovedisplayskip 8\p@ \@plus4\p@ \@minus4\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 5\p@ \@plus3\p@ \@minus3\p@
   \belowdisplayskip \abovedisplayskip
   \let\@listi\@listI}
  \normalsize
\fi

% This class uses the geometry.sty package to set the margins.
% The margins are very small for the journal version.
\if@aiaa@journal
  \RequirePackage[margin=2cm,bottom=1.3cm,footskip=8pt,headsep=0.4cm,%
                  headheight=\baselineskip]{geometry}
  % This sets the distance between columns.
  \setlength{\columnsep}{0.75cm}
\else
  \RequirePackage[margin=1in,top=0.75in,headheight=\baselineskip]{geometry}
\fi

% This section tells LaTeX to call a bunch of other packages.
\RequirePackage{graphicx}   % images
\RequirePackage{array}      % extra row height
\RequirePackage{lastpage}   % to get reference for last page number
\RequirePackage{fancyhdr}   % simple control of headers and footers
\RequirePackage{subfigure}  % package for subfloats
\RequirePackage{times}      % changes font to Times New Roman
\RequirePackage{amsmath}    % AMS packages
\RequirePackage{amsfonts}
\RequirePackage{amssymb}
\if@aiaa@submit
  \RequirePackage{setspace} % control line spacing
\fi
\if@aiaa@journal
  \RequirePackage{abstract} % use for generating thanks footnotes with twocolumn
\fi

% Here are some commands that add AIAA labels to papers.
\newcommand*{\AIAApapernumber}[1]{\def\aiaa@papernumber{#1}}\AIAApapernumber{}
\newcommand*{\AIAAconference}[1]{\def\aiaa@conference{#1}}\AIAAconference{}
\newcommand*{\AIAAcopyright}[1]{\def\aiaa@copyright{#1}}\AIAAcopyright{}
\newcommand*{\AIAAsubmitinfo}[1]{\def\aiaa@submitinfo{#1}}\AIAAsubmitinfo{}
% This gives a command to insert the name of the journal.
\newcommand*{\AIAAjournal}[1]{\def\aiaa@journal{#1}}\AIAAjournal{}
% This gives the new way of entering the abstract.
\newcommand{\AIAAabstract}[1]{
  % Declare a new variable.
  \def\aiaa@abstract{#1}
    \if@aiaa@journal
      % Extra vertical space after the abstract
      \def\insertabstract{\aiaa@abstract\vspace{0.9cm}}
    \else
      % Single-column options
      \def\insertabstract{\aiaa@abstract}
    \fi
}\AIAAabstract{}

% This creates a new method of inserting the author information.
\newcommand{\AIAAauthor}[2][]{%
  % This tells LaTeX about the author.
  \def\@author{#2}
  \def\aiaa@author{#2}
  % This gives an optional short version of the author's name.
  \def\aiaa@shortauthor{#1}
  % Check if there is anything in the author field.
  \ifx\aiaa@author\@empty
    % No insertions
    \def\insertauthor{}
    \def\insertshortauthor{}
  \else
    % Non-void insertions
    \def\insertauthor{\aiaa@author}
    \ifx\aiaa@shortauthor\@empty
      \def\insertshortauthor{\aiaa@author}
    \else
      \def\insertshortauthor{\aiaa@shortauthor}
    \fi
  \fi
}\AIAAauthor{}

% This just sets the dimensions of some spacings,
% and I really don't understand it.
\setlength{\intextsep}{0.7\baselineskip \@plus 2\p@ \@minus 1\p@}

% Try to put figures close to where they're placed in the .tex file.
\def\fps@figure{htbp}
\def\fps@table{htbp}

% Copyright commands.
\newcommand{\AIAAcopyrightA}[1]{Copyright \copyright\ #1 by the
  American Institute of Aeronautics and Astronautics, Inc. All
  rights reserved.}% rev 01/01/2002
\newcommand{\AIAAcopyrightB}[2]{Copyright \copyright\ #1 by
  #2. Published by the American Institute of Aeronautics
  and Astronautics, Inc.\ with permission.}% rev 01/01/2002
\newcommand{\AIAAcopyrightC}{This material is declared a work of the U.S.
  Government and is not subject to copyright protection in the
  United States.}% rev 01/01/2002
\newcommand{\AIAAcopyrightD}[1]{Copyright \copyright\ #1 by the American
  Institute of Aeronautics and Astronautics, Inc.  The U.S. Government
  has a royalty-free license to exercise all rights under the copyright
  claimed herein for Governmental purposes. All other rights are
  reserved by the copyright owner.}% rev 01/01/2002
\newcommand{\AIAAcopyrightDAPL}[1]{Copyright \copyright\ #1 by the American
  Institute of Aeronautics and Astronautics, Inc.  Under the copyright
  claimed herein, the U.S. Government has a royalty-free license to
  exercise all rights for Governmental purposes. All other rights are
  reserved by the copyright owner.}% rev 01/01/2002
% This command formats the actual footnote.
\newcommand\aiaa@makecopyright{%
  \begingroup
   \renewcommand\thefootnote{}
   \if@aiaa@conference\footnotetext{\aiaa@copyright}\fi
  \endgroup
}
% These are counters for the author affiliations.
\newcounter{aiaa@cthanks}
\newcounter{aiaa@cfootnote}
% This command enables multiple authors to have the same footnote hook.
\newcommand{\thanksibid}[1]{%
  \begingroup
    \setcounter{aiaa@cfootnote}{\value{footnote}}% store original
    \setcounter{aiaa@cthanks}{#1}%
    \renewcommand\thefootnote{\fnsymbol{aiaa@cthanks}}%
    \footnotemark %
    \setcounter{footnote}{\value{aiaa@cfootnote}}% reset to original
  \endgroup
}

% This section of code defines the AIAA title area.
% This section also formats the abstract.
\newcommand{\aiaa@maketitle}{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \newpage
    \global\@topnum\z@   % Prevents figures from going at top of page.
    \@maketitle
    % After creating the title, this section of the code prints the abstract.
    % The user specifies the abstract by using \AIAAabstract.
    \ifx\aiaa@abstract\@empty
      % Check for two-column format
      \if@aiaa@journal
        % Add white space between author and text.
        \vskip 1.2em
      \else
        % Delete white space between author and text.
        \vskip -0.5em
      \fi
    \else
      % Actually insert the abstract.
      \begin{center}
      \begin{minipage}[t]{13.5cm}
        \bfseries\small
        \insertabstract
      \end{minipage}
      \end{center}
    \fi
    \@thanks
  \endgroup
  % Restart the footnotes (Don't count the 'thanks' information.).
  \setcounter{footnote}{0}
  % This changes footnotes to letters instead of numbers.
  \renewcommand\thefootnote{\@alph\c@footnote}
  \aiaa@makecopyright
  \global\let\thanks\relax
  \global\let\thanksibid\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}

% This section distinguishes between the two-column and one-column options.
\if@aiaa@journal
  % For a journal, use two-column format except for the title and abstract.
  \renewcommand{\maketitle}{
    % Two-column title area
    \twocolumn[\aiaa@maketitle]
    % Remove extra headers and footers from titlepage.
    \thispagestyle{plain}\saythanks}
\else
  % Insert the title area as part of the whole one-column document.
  \renewcommand{\maketitle}{\aiaa@maketitle}
\fi

% This gives the formatting for the title.
\def\@maketitle{
  % Housekeeping
  \newpage
  \null
  % Insert information in centered environment.
  \begin{center}%
  % This part inserts the conference name if present.
  \if@aiaa@conference
    {\sffamily\scriptsize\aiaa@conference}
    \vskip1em
  \else
    \vskip\baselineskip
    \vskip1em
  \fi
  % Something to make the author footnotes work
  \let \footnote \thanks
  % Title insertion
  {
    % Use bold and two size larger
    \LARGE\bfseries
    % Move the title closer to the top for a journal.
    \if@aiaa@journal\vskip -2em\fi
    % Insert the title.
    \@title \par
  }
  % Put a gap between the title and the authors.
  \vskip 0.8cm%
  % Author insertion
  {
    % Use one font size larger.
    \large
    % Insert the author.
    \begin{tabular}[t]{c}
      \@author
    \end{tabular}\par}
  \end{center}
  % Extra spacing between author and abstract
  \par
  \vskip 1.5ex
}

% Clear the default headers and footers.
\fancyhf{}

% This section sets up the footer.
\if@aiaa@journal
  % This redefines the "plain" page style, which is used on the first page.
  \fancypagestyle{plain}{%
    \fancyhf{}
    \fancyhead[L]{\scshape\aiaa@journal}
    \fancyfoot[C]{\thepage}}
  % This generates the standard header for the other pages.
  \renewcommand{\headrulewidth}{0pt}
  % Page number on upper outer corner
  \fancyhead[RE,LO]{\thepage}
  % Authors' last names on top center
  \fancyhead[CE,CO]{\scshape\insertshortauthor}
\else
  \renewcommand{\headrulewidth}{0pt}% turn off default headrule
  \cfoot{\footnotesize\normalfont
       \thepage\ of \pageref{LastPage}\\
       \rule[.2\baselineskip]{0.5in}{0.2pt}\\
       \if@aiaa@submit
        \aiaa@submitinfo
       \else
        American Institute of Aeronautics and Astronautics
        \ifx\aiaa@papernumber\@empty
          \relax
        \else
          \if@aiaa@conference Paper \aiaa@papernumber\fi
        \fi
       \fi}
\fi
% This command simply tells LaTeX to use these headers and footers.
\pagestyle{fancy}
\setkeys{Gin}{width=\linewidth,totalheight=\textheight,keepaspectratio}
\setlength{\extrarowheight}{2pt}

% Change the figure caption styles.
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{\footnotesize\bfseries #1.~~#2}%
  \ifdim \wd\@tempboxa >\hsize
    \footnotesize\bfseries #1.~~#2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}
\setlength\belowcaptionskip{5pt plus 1pt minus 1pt}
% Change the subfigure label. 
\def\thesubfigure{\alph{subfigure})}

% Re-define the common subfloat macro
\renewcommand\subcapfont@s {\bfseries}
\renewcommand\subcaplabelfont@s {\bfseries}

% Update section numbering.
\renewcommand\thesection      {\@Roman\c@section}
\renewcommand\thesubsection   {\@Alph\c@subsection}
\renewcommand\thesubsubsection{\@arabic\c@subsubsection}
\renewcommand\theparagraph    {\@alph\c@paragraph}
\renewcommand\thesubparagraph {\@roman\c@subparagraph}
\setcounter{secnumdepth}{3}% no counters \paragraph and below
\def\@seccntformat#1{\csname the#1\endcsname.\quad}

% This gives formatting rules for section headers.
\renewcommand\section{%
  \@startsection {section}{1}{\z@}%
  {3.5ex \@plus -1ex \@minus -.2ex}%
  {2.3ex \@plus.2ex}%
  {\center\normalfont\large\bfseries}}

% This gives formatting rules for subsection headers.
\renewcommand\subsection{%
  \@startsection{subsection}{2}{\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\normalfont\normalsize\bfseries}}

% This gives formatting rules for subsubsection headers.
\renewcommand\subsubsection{%
  \@startsection{subsubsection}{3}{\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\normalfont\normalsize\itshape}}

% If you are silly enough to use paragraphs with headings, this controls them.
\renewcommand\paragraph{%
  \@startsection{paragraph}{4}{\z@}%
  {2.25ex \@plus1ex \@minus.2ex}%
  {-1em}%
  {\normalfont\normalsize\scshape}}

% Formatting for subparagraphs.
\renewcommand\subparagraph{%
  \@startsection{subparagraph}{5}{\parindent}%
  {2.25ex \@plus1ex \@minus .2ex}%
  {-1em}%
  {\normalfont\normalfont}}

% Set extra line spacing for 'submit' option.
\AtBeginDocument{
  \if@aiaa@submit
    \onehalfspacing
  \fi
}


% This loads a package that allows extra colors for links.
\RequirePackage[usenames,dvipsnames]{color}
% Custom color for references.
\definecolor{DarkGreen}{rgb}{0,0.6,0}

% This will make labels and references hyperlinks.
\RequirePackage[pdftex,pagebackref=true]{hyperref}
% This controls some settings that affect the appearance of links.
\hypersetup{
  colorlinks=true,
  pdfstartview={FitH},
  citecolor=DarkGreen,
  linkcolor=Maroon
}
