%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Created by Forrest Bicker
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ProvidesClass{resume}[Resume]
\usepackage[clean]{svg}

\LoadClass[10pt,letterpaper]{article} % Font size and paper type
\usepackage{multirow}
\usepackage{calc}
\usepackage[parfill]{parskip} % Remove paragraph indentation
\usepackage{array} % Required for boldface (\bf and \bfseries) tabular columns
\usepackage{ifthen} % Required for ifthenelse statements
\usepackage{xcolor}
\usepackage{fontawesome}

\usepackage{xstring}


\usepackage[hidelinks,unicode]{hyperref}
\hypersetup{%
	pdftitle={},
	pdfauthor={},
	pdfsubject={},
	pdfkeywords={},
}

% \usepackage{fontspec}

\pagestyle{empty} % Suppress page numbers

%-------------------------
%	HEADINGS COMMANDS: Commands for printing name and address
%-------------------------

\def \name#1{\def\@name{#1}} % Defines the \name command to set name
\def \tagline#1{\def\@tagline{#1}}

\def \github#1 {\def\@github{#1}}
\def \email#1 {\def\@email{#1}}
\def \phone#1 {\def\@phone{#1}}
\def \linkedin#1 {\def\@linkedin{#1}}
\def \website#1 {\def\@website{#1}}
\def \home#1 {\def\@home{#1}}


\definecolor{doublebar}{HTML}{2a3990} % doublebar color

\definecolor{headingcolor}{HTML}{0E0E0E} % 5% grayscale
\definecolor{itemcolor}{HTML}{222222} % 10% grayscale
\definecolor{subheadingcolor}{HTML}{5F5F5F} % 30% grayscale

\definecolor{linkedincolor}{HTML}{0073b1} 
\definecolor{websitecolor}{HTML}{000000} 
\definecolor{githubcolor}{HTML}{6D2B88} 

\newcommand{\sectionheader}[1]{
	\vspace{2.85ex}
	\hrule % Horizontal line
	\vspace{-2.85ex}
	\colorbox{white}{\MakeUppercase{\bf{#1}}} % White box overlays line
}
\newcommand{\link}[1]{\href{#1}{#1}}


\newcommand{\img}[1]{\IfEndWith{#1}{png}{\includegraphics[width=0.9em, height=0.9em]{#1}}{\includesvg[width=0.9em, height=0.9em]{#1}}}

\newcommand{\headerline}[3]{
	\par\noindent
	\makebox[\textwidth][s]{\rlap{#1}\hfill#2\hfill\llap{#3}}\par
}


\newcommand{\heading}[1]{\color{headingcolor} #1}
\newcommand{\subheading}[1]{\itshape\color{subheadingcolor} #1}

% \printname is used to print the name as a page header


\newcommand{\doublebar}[0]{{\color{doublebar}\hrule\vspace{.2em}\hrule}}

\def \printname {
	\doublebar
	\begingroup
	\begin{center}
		
		\headerline{
			\raisebox{1ex}{\href{mailto:\@email}{\faEnvelope\space\footnotesize\@email}}
			}{
			\raisebox{-2ex}{
				\textsc{\namesize \@name}}
			}{
			\raisebox{1ex}{\href{https://github.com/\@github} {{\color{githubcolor}\faGithub}\space\@github}} % github
		}
		\vspace{-3ex}
		\headerline{
			\href{tel:\@phone}{\faPhone\space\space\@phone}
			}{
			
			}{
			\href{https://www.linkedin.com/in/\@linkedin}{{\color{linkedincolor}\faLinkedinSquare}\space\@linkedin}
		}
		\vspace{-1ex}
		\headerline{{\space\faHome\space\scriptsize\scalebox{.90}[1.0]{\@home}}
			}{
			\texttt{\color{subheadingcolor}\@tagline}
			}{
			\href{https://\@website}{{\color{websitecolor}\faFolderOpen}\space\@website}
		}
	\end{center}
	\endgroup
	\vspace{1ex}
	\doublebar
}


%-------------------------
%	PRINT THE HEADING LINES
%-------------------------

\let\ori@document=\document
\renewcommand{\document}{
	\ori@document  % Begin document
	\printname % Print the name specified with \name
	\smallskip
}

%-------------------------
%	SECTION FORMATTING
%-------------------------

% Defines the rSection environment for the large sections within the CV
\newenvironment{rSection}[1]{ % 1 input argument - section name
	% \vspace{0 pt}
	% \sectionlineskip
	\sectionheader{#1}
	\begin{list}{}{ % List for each individual item in the section
			\setlength{\leftmargin}{1.5em} % Margin within the section
		}
		\item[]
		      }{
	\end{list}
}

%-------------------------
%	HEADER FORMATTING
%-------------------------
% \def \companyheader#2 [][]{}
% \def \titleheader#2 [][]{}
\newcommand{\companyheader}[2]{
	{{\heading{\bfseries{#1}}}\hfill\heading{#2}} % Bold company name and date on the right
}

\newcommand{\jobtitleheader}[2]{
	\vspace{2pt}
	{\subheading{#1\hfill#2}}
}

\newcommand{\addedjobheader}[2]{
	{\subheading{#1\hfill#2}}
}

\def\logowidth{4.5ex}
\newcommand{\logo}[1]{\includesvg[width=\logowidth, height=\logowidth]{#1}}

\newcommand{\combinedjobheader}[5]{
	\ifthenelse{\equal{#5}{}}{
		\companyheader{#1}{#2}\\
		\jobtitleheader{#3}{#4}\\
		\vspace{-14pt}
	}{
	\vspace{2pt}
	\hspace{-20pt}
	\setlength\tabcolsep{4pt}
	% \setlength\extrarowheight{-3.2pt}
	\renewcommand{\arraystretch}{0.8}
	% width = page width - logo width + hspace + table padd - 30pt
	\begin{tabular}{p{\logowidth} m{\textwidth-\logowidth+20pt-4pt-30pt}}
		% \hline
		\multirow{2}{\logowidth}{\logo{#5}} & \companyheader{#1}{#2}\\
		& \jobtitleheader{#3}{#4}\\% Bold  company name and date on the right
		% \hline
	\end{tabular}
	\vspace{-4pt}
	}
}


\newenvironment{rSubsection}[5]{ % 4 input arguments - company name, year(s) employed, job title and location
	\vspace{-4pt}
	\combinedjobheader{#1}{#2}{#3}{#4}{#5}
	  
	\color{itemcolor}
	\begin{list}{$\cdot$}{\leftmargin=0em} % \cdot used for bullets, no indentation
		\itemsep -0.5em \vspace{-0.5em} % Compress items in list together for aesthetics
		}{
	\end{list}
	\vspace{0.5em} % Some space after the list of bullet points
}

% The below commands define the whitespace after certain things in the document - they can be \smallskip, \medskip or \bigskip
\def\namesize{\huge} % Size of the name at the top of the document
\def\addressskip{\smallskip} % The space between the two address (or phone/email) lines
\def\sectionlineskip{\medskip} % The space above the horizontal line for each section
\def\nameskip{\bigskip} % The space after your name at the top
\def\sectionskip{\medskip} % The space after the heading section
