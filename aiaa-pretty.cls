% I dedicate this template unto thee, Sara C. Spangelous.
%
%
%%
%% This is file `aiaa-pretty.cls'.  It is based off of aiaa-tc.cls, which was
%% written by Bil Kleb, Bill Wood, and Erich Knauseberger.
%%
%% Editing this file is perfectly permitted by the distributing author, Derek
%% Dalle, but changing the name is recommended before making any major changes.
%%
%% -----------------------------------------------------------------------------
%% IMPORTANT USE GUIDELINES:
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

%% ----- INITIAL DEFINITIONS ---------------------------------------------------
% This prevents the compiler from running on old versions of LaTeX.
\NeedsTeXFormat{LaTeX2e}

% This command gives the name of the class.
\ProvidesClass{aiaa-pretty}[2010/01/10 v2.0 AIAA paper]


%% ----- OPTIONS ---------------------------------------------------------------
% LaTeX help: logical variables
% Create a new logical variable using
%   \newif\if@something
% This creates a variable \@something with a default of false.

% These variables control the document type.
\newif\if@aiaa@conference
\newif\if@aiaa@submit
\newif\if@aiaa@journal
\newif\if@aiaa@plain

% These variables control which items to show.
\newif\if@q@abstract
\newif\if@q@author
\newif\if@q@shortauthor
\newif\if@q@title
\newif\if@q@footer
\newif\if@q@header
\newif\if@q@backref
\newif\if@q@copyright
\newif\if@q@papernumber
\newif\if@q@conference
\newif\if@q@lastpage

% This value can be used to hide any AIAA labels.
\newif\if@q@plain

% These variables relate to the hyperref links.
\newif\if@pdf@links
\newif\if@pdf@plain
\newif\if@pdf@bright
\newif\if@q@dvi

% This option allows the user to compress the entire document.
\newif\if@q@compress

% This sets up any of the above variables that should default to true.
\@pdf@linkstrue

% Document format options
\DeclareOption{conference}{\@aiaa@conferencetrue}
\DeclareOption{submit}{\@aiaa@submittrue}
\DeclareOption{journal}{\@aiaa@journaltrue}
% Option to hide footers
\DeclareOption{plain}{\@q@plaintrue}
% Option to compress document
\DeclareOption{compress}{\@q@compresstrue}
% Option to use backward references for references
\DeclareOption{backrefs}{\@q@backreftrue}
% Option to put a link to the last page on every page.
\DeclareOption{lastpage}{\@q@lastpagetrue}
% Option to not use any PDF features
\DeclareOption{dvi}{\@q@dvitrue\@pdf@linksfalse}
% Options to change the colors of the links
\DeclareOption{links=false}{\@pdf@linksfalse}
\DeclareOption{links=plain}{\@pdf@plaintrue}
\DeclareOption{links=bright}{\@pdf@brighttrue}

% This passes any other options on to the article class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}%
 \typeout{Unknown option: passing '\CurrentOption'
  option on to the standard LaTeX article class.}}

% This command appears to tell LaTeX to simply process the class options.
\ProcessOptions


%% ----- DOCUMENT FORMAT -------------------------------------------------------
% This control structure calls the basic LaTeX article.cls class.
\if@aiaa@submit
 % Submit class: large font and spacing in single column
 \LoadClass[letterpaper,12pt]{article}
 % Make sure that other formats are suppressed.
 \@aiaa@conferencefalse \@aiaa@journalfalse \@aiaa@plainfalse
\else\if@aiaa@journal
 % Journal class: mirror the appearance of an AIAA journal article
 \LoadClass[letterpaper,10pt,twoside]{article}
\else
 % Conference class: format appropriate for AIAA conference paper
 \LoadClass[letterpaper,10pt]{article}
\fi\fi

% Change the base font size for journal papers.
\if@aiaa@journal
 % Must change the \normalisize command
 \renewcommand\normalsize{%
  % This does the main resizing work.
  % The first number is the size of the text.
  % The second number is the size of the line.
  \@setfontsize\normalsize\@ixpt\@xpt%
  % Set the amount of vertical white space before and after equations.
  \abovedisplayskip 8\p@ \@plus4\p@ \@minus4\p@
  \belowdisplayskip 8\p@ \@plus4\p@ \@minus4\p@
  \abovedisplayshortskip \z@ \@plus3\p@
  \belowdisplayshortskip 5\p@ \@plus3\p@ \@minus3\p@
  % I do not know what this means.
  \let\@listi\@listI
 }
\fi

% This class uses the geometry.sty package to set the margins.
\if@aiaa@journal
 % The margins are very small for the journal version.
 \RequirePackage[margin=2cm,bottom=1.3cm,footskip=8pt,headsep=0.4cm,%
  headheight=\baselineskip]{geometry}
 % This sets the distance between columns.
 \setlength{\columnsep}{0.75cm}
\else
 % Larger margins for conference class
 \RequirePackage[margin=1in,top=0.75in,bottom=0.9in, %
  headheight=0.5\baselineskip]{geometry}
\fi


%% ----- PACKGAGES -------------------------------------------------------------
% This section tells LaTeX to call a bunch of other packages.
\RequirePackage{graphicx}   % images
\RequirePackage{array}      % extra row height
\RequirePackage{lastpage}   % to get reference for last page number
\RequirePackage{fancyhdr}   % simple control of headers and footers
\RequirePackage{subfigure}  % package for subfloats
\RequirePackage{times}      % changes font to Times New Roman
\RequirePackage{verbatim}   % New verbatim format
\RequirePackage{textcomp}   % proper single quotes in verbatim
\RequirePackage{ifthen}     % logical structure
\RequirePackage{amsmath}    % AMS packages
\RequirePackage{amsfonts}
\RequirePackage{amssymb}

% Need a package to set 1.5-spaced lines for 'submit'
\if@aiaa@submit\RequirePackage{setspace}\fi
% Need a package to fix the author footnotes in two-column format
\if@aiaa@journal\RequirePackage{abstract}\fi


%% ----- IDENTIFIERS AND ABSTRACT ----------------------------------------------
% Variables that hold the value of various identifiers.
\renewcommand{\@author}{}
\newcommand{\@shortauthor}{}
\newcommand{\@abstract}{}
\renewcommand{\@title}{}
\newcommand{\@copyright}{}
\newcommand{\@submitinfo}{}
\newcommand{\@conference}{}
\newcommand{\@journal}{}

% New author command
\renewcommand*{\author}[2][]{ %
 % Set the main author field.
 \renewcommand{\@author}{#2} %
 % Set a flag to use it.
 \@q@authortrue %
 % Check for an optional argument.
 \ifthenelse{\equal{#1}{}}{}{ %
  % Set the short author field.
  \renewcommand{\@shortauthor}{#1} %
  % Set a flag to use it.
  \@q@shortauthortrue %
 } %
}
% Command to set just the short author.
\newcommand{\shortauthor}[1]{ %
 \renewcommand{\@shortauthor}{#1} %
 \@q@shortauthortrue}
% Legacy command
\let\AIAAauthor\author

% New abstract command
\renewcommand{\abstract}[1]{ %
 \renewcommand{\@abstract}{} %
 \@q@abstracttrue}
% Legacy command
\let\AIAAabstract\abstract

% New title command
\renewcommand{\title}[1]{ %
 \renewcommand{\@title}{#1} %
 \@q@titletrue}
% Legacy command
\let\AIAAtitle\title

% New abstract command
\renewcommand{\abstract}[1]{
 \renewcommand{\@abstract}{#1}\@q@abstracttrue}
% Legacy command
\let\AIAAabstract\abstract

% These are counters for the author affiliations.
\newcounter{aiaa@cthanks}
\newcounter{aiaa@cfootnote}
% This command enables multiple authors to have the same footnote hook.
\newcommand{\thanksibid}[1]{%
 \begingroup
  % Store the current value of the footnote counter.
  \setcounter{aiaa@cfootnote}{\value{footnote}} %
  % Set the thanks counter to the argument
  \setcounter{aiaa@cthanks}{#1} %
  % Get the footnote symbol corresponding to above
  \renewcommand\thefootnote{\fnsymbol{aiaa@cthanks}} %
  % Make a footnote.
  \footnotemark %
  % Reset the footnote counter to the original value.
  \setcounter{footnote}{\value{aiaa@cfootnote}} %
 \endgroup %
}


% Commands to insert the identifiers
\newcommand{\insertauthor}{\@author}
\newcommand{\insertshortauthor}{\@shortauthor}
\newcommand{\inserttitle}{\@title}
\newcommand{\insertabstract}{\@abstract}


%% ----- FLOATS ----------------------------------------------------------------
% This sets the distance between a float and the paragraph.
\setlength{\intextsep}{0.7\baselineskip \@plus 2\p@ \@minus 1\p@}

% This sets the priorization for where floats should go.
\renewcommand{\fps@figure}{htbp}
\renewcommand{\fps@table}{htbp}


%% ----- COPYRIGHT -------------------------------------------------------------





%% ----- TITLE AREA ------------------------------------------------------------
% Define a new command that does most of the work of making the title.
\renewcommand{\@maketitle}{ %
 % Housekeeping
 \newpage %
 % Change the footnote style to silly marks.
 \renewcommand\thefootnote{\@fnsymbol\c@footnote} %
 % Insert the information in a centered environment
 \begin{center} %
  % Initial vertical space
  \vskip1em %
  % Set the footnote command equal to the thanks command.
  \let\footnote\thanks %
  % Check for a title
  \if@q@title %
   {\LARGE \bfseries \inserttitle} %
  \fi %
  % Check for an author field.
  \if@q@author %
   % Title-to-author gap
   \if@q@title \vskip 0.8cm \fi %
   % Insert the author.
   { %
    % Increase font size for all fields of author.
    \large %
    % Insert author in a tabular environment.
    \begin{tabular}[t]{c}\insertauthor\end{tabular}
   } %
  \fi %
  % Check for an abstract.
  \if@q@abstract %
   % Check which gap to insert above.
   \if@q@author %
    % Author-to-abstract skip
    \vskip 3em %
   \else\if@q@title %
    % Title-to-abstract skip
    \vskip 2.5em %
   \fi\fi %
   % Insert the abstract
   \begin{minipage}{13.5cm} %
    \bfseries \small \insertabstract %
   \end{minipage} %
   % Abstract-to-text gap
   \vskip 3em %
  \else\if@q@author %
   % Author-to-text gap
   \vskip 3em %
  \else\if@q@title %
   %Title-to-text gap
   \vskip 2.5em %
  \fi\fi\fi %
 \end{center} %
 % Produce the author footnotes.
 \@thanks %
 % Restart the footnotes (Don't count the 'thanks' information.).
 \setcounter{footnote}{0} %
 % This changes footnotes to letters instead of numbers.
 \renewcommand\thefootnote{\@alph\c@footnote}
}

% This section distinguishes between the two-column and one-column options.
\if@aiaa@journal
 % For a journal, use two-column format except for the title and abstract.
 \renewcommand{\maketitle}{
  % Two-column title area
  \twocolumn[\@maketitle]
  % Remove extra headers and footers from titlepage.
  \thispagestyle{plain}\saythanks}
\else
 % Insert the title area as part of the whole one-column document.
 \renewcommand{\maketitle}{\@maketitle}
\fi



