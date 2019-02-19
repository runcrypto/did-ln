% technical.cls
%
% A LaTeX2e document class for writing kirona technical manuals.

%% runcrypto.cls
%% Copyright (c) 2017 Michael A. Hawkins
%
% This work may be distributed ands/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%    http://www.latex-project.org/lppl.txt
% and version 2003/12/01 or later.
%
% This work has the LPPL maintenance status "author-maintained".
%
% This work consists of the files runcrypto.cls

\def\fileversion{0.1}
\def\filedate{2019/02/19}
\def\fileauthor{Michael A. Hawkins}

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{runcrypto}[\filedate\space Version \fileversion\space by \fileauthor]
\LoadClass[11pt,twoside,a4paper]{article}

\RequirePackage[a4paper,
	lmargin=0.1111\paperwidth,
	rmargin=0.1111\paperwidth,
	tmargin=0.1111\paperheight,
	bmargin=0.1111\paperheight]{geometry}	% margins
\RequirePackage{multicol}                       % required for multicolumns
\RequirePackage[toc]{multitoc}
\RequirePackage{tikz}
\RequirePackage{listings}
\lstdefinestyle{DOS}
{
    backgroundcolor=\color{black},
    basicstyle=\scriptsize\color{white}\ttfamily,
    breaklines=true
}

\renewcommand*{\multicolumntoc}{2}
\RequirePackage[scaled]{helvet}			% use helvetica font

\RequirePackage{enumitem}			% Includes lists
\RequirePackage[all]{nowidow}			% tries to remove widows
\RequirePackage[protrusion=true,
	expansion=true]{microtype}		% Improves typography, load after fontpackage is selected
\RequirePackage[pdftex,
	linkcolor=black,
	pdfborder={ 0 0 0 }]{hyperref}		% format links for pdf
\RequirePackage{import}
\linespread{1.2}				% set line space
\hyphenpenalty=10000

\renewcommand*\familydefault{\sfdefault}
\RequirePackage[T1]{fontenc}

%------------------------
% Set PDF information and add title
%------------------------
\hypersetup{
	pdfsubject = {},
	pdftitle = {},
	pdfauthor = {}
}

\RequirePackage{pgf-umlsd}
\RequirePackage{multirow}

%------------------------
% Commands used in generating title page
%------------------------


\newcommand{\titletext}[1]{%
	\def\@titletext{#1} 
}
\newcommand{\subtitletext}[1]{%
	\def\@subtitletext{#1} 
}
\newcommand{\titleimage}[1]{%
	\def\@titleimage{#1}
}

\newcommand{\maketitlepage}{%
	\newgeometry{left=0mm,right=0mm,top=0mm,bottom=0mm}
	\hspace*{-6.5mm}
	\begin{tikzpicture}
		\draw node [left,inner sep=0mm] (background) at (0,0) {\includegraphics[width=1\linewidth]{\@titleimage}};
		\node [text width=150mm] (title) at (-110mm,70mm) {
			\color{white}
			\bfseries
			\fontsize{36}{\the\numexpr 36*1.2}
			\selectfont
			\@titletext
			\\
			\rule{10cm}{1pt}
			\\
			\vspace{10mm}
			\color{white}
			\mdseries
			\fontsize{24}{\the\numexpr 24*1.2}
			\selectfont
			\@subtitletext
		};

	\end{tikzpicture}
	\newgeometry{left=30mm,right=20mm,top=30mm,bottom=20mm}
	\pagenumbering{gobble}
}

%------------------------
% Commands used for typesetting
%------------------------
\newcommand{\diddoc}{DID Document\ }
