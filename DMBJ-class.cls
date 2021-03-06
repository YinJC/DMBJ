%# -*- coding:utf-8 -*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{DMBJ-class}
    [2018/04/08 v1.0 DaoMuBiJi document class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions\relax

\LoadClass[cs4size,openany,nofonts]{ctexbook}

\RequirePackage[xetex]{geometry}
\RequirePackage[pagestyles,clearempty]{titlesec}
\RequirePackage[titles]{tocloft}
\RequirePackage{calc,xcolor}
\RequirePackage[xetex, bookmarksnumbered, pdfstartview={XYZ null null 1}, pdfborder=001,
                pdfpagemode=UseNone, pdfprintscaling=None]{hyperref}

\hypersetup{
  pdfinfo={
    Title   = {盗墓笔记},
    Author  = {南派三叔},
    Creator = {XeLaTeX + xeCJK + CTeX}
  }
}

\let\HyPsd@Warning\@gobble\relax

%\geometry{papersize={145mm,210mm}, textwidth=110mm, lines=30, inner=15mm,
%          top=20mm, bindingoffset=5mm, headheight=10mm, headsep=6mm, foot=5mm}
\geometry{screen,paperheight=14.4cm,paperwidth=10.8cm,lines=30, inner=15mm,left=2mm,right=2mm,
	top=20mm,bottom=5mm}
%\geometry{screen,paperheight=14.4cm,paperwidth=10.8cm,left=2mm,right=2mm,top=2mm,bottom=5mm}

\setmainfont{TeX Gyre Pagella}

\ExplSyntaxOn
\cs_new:Nn \DMBJ_includechapters:n
  { \prg_replicate:nn {#1} \DMBJ_includechapters: }
\int_new:N \g_DMBJ_chapter_int
\cs_new:Nn \DMBJ_includechapters:
  {
    \int_gincr:N \g_DMBJ_chapter_int
    \int_compare:nTF { \g_DMBJ_chapter_int < \c_ten }
      {
        \tl_set:Nx \l_DMBJ_chapter_tl { 0 0 }
      }
      {
        \int_compare:nTF { \g_DMBJ_chapter_int < \c_one_hundred }
          { \tl_set:Nx \l_DMBJ_chapter_tl { 0 } }
          { \tl_set:Nx \l_DMBJ_chapter_tl { \c_empty_tl } }
      }
    \include{includefiles/DMBJ\l_DMBJ_chapter_tl\int_use:N\g_DMBJ_chapter_int}
  }
\cs_new_eq:NN \includechapters \DMBJ_includechapters:n
\file_if_exist:nTF { GB.range } { \file_input:n { GB.range } }
  {
    \group_begin:
    \iow_new:N \l_GB_range_stream
    \clist_clear_new:N \g_GB_range_clist
    \bool_set_true:N \l_tmpa_bool
    \tex_font:D \test_font_a "[FZXSSGB18030.TTF]"
    \tex_font:D \test_font_b "[FZXSSGB18030.TTF]"
    \int_zero:N \l_tmpa_int
    \int_zero:N \l_tmpb_int
    \test_font_a
    \loop
      \reverse_if:N \etex_iffontchar:D \tex_font:D \l_tmpa_int
        \group_begin:
        \test_font_b
        \etex_iffontchar:D \tex_font:D \l_tmpa_int
          \bool_if:NTF \l_tmpa_bool
            {
              \int_gset_eq:NN \l_tmpb_int \l_tmpa_int
              \int_gset_eq:NN \l_tmpc_int \l_tmpa_int
              \bool_gset_false:N \l_tmpa_bool
            }
            {
              \int_compare:nNnF \l_tmpa_int = { \l_tmpb_int + \c_one }
                {
                  \int_compare:nNnTF \l_tmpc_int = \l_tmpb_int
                    { \clist_gput_right:NV \l_tmpa_clist \l_tmpb_int }
                    {
                      \clist_gput_right:Nx \l_tmpa_clist
                        {
                          \int_compare:nNnTF \l_tmpc_int = { \l_tmpb_int - \c_one }
                            { \int_use:N \l_tmpc_int, \int_use:N \l_tmpb_int }
                            { \int_use:N \l_tmpc_int -> \int_use:N \l_tmpb_int }
                        }
                    }
                  \int_gset_eq:NN \l_tmpc_int \l_tmpa_int
                }
              \int_gset_eq:NN \l_tmpb_int \l_tmpa_int
            }
        \fi:
        \group_end:
      \fi:
      \if_int_compare:w \l_tmpa_int < "FFFF
        \int_incr:N \l_tmpa_int
    \repeat
    \clist_gput_right:Nx \l_tmpa_clist
      {
        \int_compare:nNnTF \l_tmpc_int = \l_tmpb_int
          { \int_use:N \l_tmpb_int } { \int_use:N \l_tmpc_int -> \int_use:N \l_tmpb_int }
      }
    \iow_open:Nn \l_GB_range_stream { GB.range }
    \iow_now:Nx \l_GB_range_stream { \exp_not:n { \clist_gset:Nn \g_GB_range_clist } { \l_tmpa_clist } }
    \iow_close:N \l_GB_range_stream
    \group_end:
  }
\xeCJKDeclareSubCJKBlock{GB18030}{ \g_GB_range_clist }
\xeCJKDeclareSubCJKBlock{Ext-B}{ "20000 -> "2A6DF }
\ExplSyntaxOff

\xeCJKsetup {
   CheckSingle = true,
  AutoFakeBold = false,
 AutoFakeSlant = false,
     CJKecglue = {},
    PunctStyle = kaiming,
 KaiMingPunct+ = {：；},
}

\defaultCJKfontfeatures{GB18030=*}

\setCJKmainfont[
     BoldFont=NotoSansHans-DemiLight.otf,
   ItalicFont=MF KeSong (Noncommercial).otf,
  SlantedFont=NotoSansHans-DemiLight.otf,
     GB18030={[
       BoldFont=FZXSSGB18030.TTF,
     ItalicFont=FZXSSGB18030.TTF,
    SlantedFont=FZXSSGB18030.TTF]{FZXSSGB18030.TTF}},
       Ext-B={[
     ItalicFont={FZXSSGB18030.TTF}]{FZXSSGB18030.TTF}}
]{SourceHanSerifSC-Regular.otf}

\setCJKsansfont[
     BoldFont=FZXSSGB18030.TTF,
   ItalicFont=FZXSSGB18030.TTF,
  SlantedFont=MF KeSong (Noncommercial).otf,
     GB18030={[
       BoldFont=FZXSSGB18030.TTF,
     ItalicFont=FZXSSGB18030.TTF,
    SlantedFont=FZXSSGB18030.TTF]{FZXSSGB18030.TTF}}
]{MF TheGoldenEra (Noncommercial).otf}

\setCJKmonofont[
     BoldFont=NotoSansHans-Medium.otf,
   ItalicFont=MF KeSong (Noncommercial).otf,
  SlantedFont=MF KeSong (Noncommercial).otf,
     GB18030={[
       BoldFont=FZXSSGB18030.TTF,
     ItalicFont=FZXSSGB18030.TTF,
    SlantedFont=FZXSSGB18030.TTF]{FZXSSGB18030.TTF}}
]{NotoSansHans-DemiLight.otf}

\newCJKfontfamily{\fzwkai}   {MF KeSong (Noncommercial).otf}  % 方正北魏楷书
\newCJKfontfamily{\fzzhdxian}{SourceHanSerifSC-Regular.otf} % 方正中等线
\newCJKfontfamily{\fzltheib} {NotoSansHans-DemiLight.otf}         % 方正兰亭黑扁
\newCJKfontfamily{\fzydzhhei}{NotoSansHans-DemiLight.otf}          % 方正韵动中黑
\newCJKfontfamily{\fzzhysong}{SourceHanSerifSC-Regular.otf}             % 方正中雅宋
\newCJKfontfamily{\fzqiti}   {MF KeSong (Noncommercial).otf}                  % 方正启体
\newCJKfontfamily{\fzliukai}[GB18030=FZSXSLKJW_GB18030.ttf]{MF KeSong (Noncommercial).otf}% 方正苏新诗柳楷简体

\parskip           \z@
\clubpenalty      -\@m
\widowpenalty      \z@
\interlinepenalty -\@m

\raggedbottom

\newcommand\titlematter{%
  \cleardoublepage
  \@mainmatterfalse
  \pagestyle{empty}%
  \pagenumbering{Alph}}
\renewcommand\frontmatter{%
  \cleardoublepage
  \@mainmatterfalse
  \pagestyle{main}%
  \pagenumbering{Roman}}
\renewcommand\mainmatter{%
  \cleardoublepage
  \@mainmattertrue
  \pagestyle{main}%
  \pagenumbering{arabic}}
\renewcommand\backmatter{%
  \clearpage
  \@mainmatterfalse}
\newcommand\fillinner{%
  \if@twoside
    \ifodd\c@page\raggedleft\else\raggedright\fi
  \else
    \raggedleft
  \fi}
\newcommand\fillouter{%
  \if@twoside
    \ifodd\c@page\raggedright\else\raggedleft\fi
  \else
    \raggedright
  \fi}

\DeclareRobustCommand*\KG{\kern\ccwd}
\DeclareRobustCommand*\@cdot{\textcentereddot}

\RequirePackage{fancybox}
\RequirePackage{graphicx}
\RequirePackage{wallpaper}
\RequirePackage{indentfirst}


\def\CTEX@postchapter{章}
\renewcommand\contentsname{目\KG 录}

\newdimen\ruleheight
\ruleheight=.8\p@
\renewcommand\setheadrule[2][2mm]{%
  \ifdim#1=\z@
    \let\makeheadrule\@empty
  \else
    \def\makeheadrule{\rule[-#1]{\linewidth}{#2}}%
  \fi}

\newpagestyle{main}[\sffamily\small]{%
  \sethead[\rmfamily\bfseries\@cdot\enskip\thepage\enskip\@cdot]
          [盗墓笔记]
          [\ifthechapter{第\thechapter 章}{}]
          {\chaptertitle}
          {}
          {\rmfamily\bfseries\@cdot\enskip\thepage\enskip\@cdot}%
  \setheadrule\ruleheight}

\renewpagestyle{plain}{}

\def\@chapter[#1]#2{%
  \ifnum \c@secnumdepth >\m@ne
    \if@mainmatter
      \refstepcounter{chapter}%
      \typeout{第\thechapter 章}%
      \addcontentsline{toc}{chapter}
        {\protect\numberline{第\thechapter 章}#1}%
    \else
      \addcontentsline{toc}{chapter}{#1}%
    \fi
  \else
    \addcontentsline{toc}{chapter}{#1}%
  \fi
  \chaptermark{#1}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  \if@twocolumn
    \@topnewpage[\@makechapterhead{#2}]%
  \else
    \@makechapterhead{#2}%
  \@afterheading
  \fi}

\definecolor{darkgreen}{cmyk}{0.75002,0,1,0}

%\titleformat{\part}[display]%
%{\fzqiti\zihao{-2}}%
%{\color{red}\filleft \shadowbox{\begin{minipage}{1em} \textcolor{gray}{第\chinese{part}部分}\end{minipage}}}%
%{2ex}%
%{\zihao{2}\color{purple}\filcenter}[]

\ctexset{%
	part = {%
		nameformat = \mbox{}\hfill\fzqiti\color{red}\partnamebox,
		titleformat = \fzqiti\color{purple}\parttitlebox,
		aftertitle = \par
	}
}

\newcommand{\partnamebox}[1]{\shadowbox{\parbox{\ccwd}{\zihao{-2}\textcolor{gray}{#1}}}}
\newcommand{\parttitlebox}[1]{\begin{minipage}{\ccwd}{\zihao{2}#1}\end{minipage}}

\titleformat{\chapter}[display]
            {\color{darkgreen}\zihao{4}\fzzhysong\ifthechapter{\fillinner}{\filcenter}}
            {\color{darkgreen}\fzltheib\fillouter\zihao{-4}第\thechapter 章\\[-2\p@] \titlerule[\ruleheight]\addvspace{-\baselineskip}}
            {\z@}
            {\Huge
            	\filright}
            [{\titlerule[1pt]}]

\titlespacing*{name=\chapter,numberless}
              {\z@}{-10\p@}{2\baselineskip-\ccwd}
\titlespacing*{\chapter}
              {\z@}{-13\p@}{2\baselineskip-\ccwd}

\newcommand\raisetext[2][.5\baselineskip]{\raisebox{#1}[\z@][\z@]{#2}}

\newcount\toc@cnt@
\chardef\toc@num@=2000
\newdimen\toc@num@wid
\toc@num@wid=5\ccwd
\renewcommand{\numberline}[1]{\CTEXsetfont
  \settowidth\@tempdima{#1}%
  \global\advance\toc@cnt@ \@ne\relax
  \ifnum \toc@cnt@ >\toc@num@\relax
    \def\toc@cmd@{\let\CJKglue\hfill}%
    \@tempdima=\toc@num@wid
  \else
    \let\toc@cmd@\relax
  \fi
  \raisetext[0\baselineskip]{\hb@xt@\@tempdima{\toc@cmd@\@cftbsnum #1\@cftasnum}}%
  \advance\@tempdima\ccwd
  \@cftasnumb}
\cftsetindents{chapter}{\z@}{\z@}
\setlength\cftbeforechapskip{\z@}
\renewcommand\cftdot{\@cdot}
\renewcommand\cftdotsep{3.5}
\renewcommand\cftchapfont{\fzwkai}
\renewcommand\cftchappresnum{\fzzhdxian}
\renewcommand\cftchapaftersnumb{\kern\ccwd\global\hangindent=\@tempdima}
\renewcommand\cftchapleader{\cftsecleader}
\renewcommand\cftchappagefont{\rmfamily}
\renewcommand\cftchapfillnum[1]{\enspace\cftchapleader
  \nobreak\cftchappagefont #1\cftchapafterpnum\par}
  
\cftsetindents{part}{\z@}{\z@}
\setlength\cftbeforepartskip{\z@}
\renewcommand\cftdot{\@cdot}
\renewcommand\cftdotsep{3.5}
\renewcommand\cftpartfont{\fzwkai}
\renewcommand\cftpartpresnum{\fzzhdxian}
\renewcommand\cftpartaftersnumb{\kern\ccwd\global\hangindent=\@tempdima}
\renewcommand\cftpartleader{\cftsecleader}
\renewcommand\cftpartpagefont{\rmfamily}
\renewcommand\cftpartfillnum[1]{\enspace\cftpartleader
  \nobreak\cftpartpagefont #1\cftpartafterpnum\par}

\renewenvironment{quote}{\CTEXindent
    \@beginparpenalty\@m\relax
    \list{}{%
      \labelwidth\z@
      \labelsep\z@
      \leftmargin\parindent
      \parsep\parskip
      \itemsep\z@
      \topsep\z@
      \partopsep\parskip
      \listparindent\parindent
      \itemindent\listparindent
      \advance\itemindent\labelsep}%
    \item\relax\itshape}
  {\endlist\ignorespacesafterend}

\renewcommand*{\[}{\begin{quote}\obeylines}
\renewcommand*{\]}{\end{quote}}

\newcommand\named[1]{%
  \unskip\nobreak\hfill\allowbreak\null\nobreak\hfill\quad\hbox{\normalfont ——\,#1}}

%\newcommand\named[1]{{\unskip\nobreak\hfil\penalty50\quad\hbox{}\nobreak\hfill
%  \normalfont ——\,#1\parfillskip\z@ \finalhyphendemerits\z@ \par}}


\newcommand\cipaim[1]{{\upshape\fzzhdxian 【#1】}\enspace\ignorespaces}

\def\textuni#1{\char"#1}

\def\textJinXia {\makebox[\ccwd]{\scalebox{.85}[.9]{釒}\kern-.55em\scalebox{.65}[1]{夏}}}
\def\textShiJie {\makebox[\ccwd]{\scalebox{.9}[1]{飠}\kern-.5em\scalebox{.6}[1]{皆}}}
\def\textShiHe  {\makebox[\ccwd]{\scalebox{.9}[1]{飠}\kern-.47em\scalebox{.58}[1]{禾}}}
\def\textSiTang {\makebox[\ccwd]{\scalebox{.6}[1]{糹}\kern-.3em\scalebox{.7}[1]{堂}}}
\def\textShiDian{\makebox[\ccwd]{砷\kern-.6em\fboxsep\z@\colorbox{white}{\kern-.1em\scalebox{.7}[1]{店}}}}
\def\textShiFou {\makebox[\ccwd]{砷\kern-.6em\fboxsep\z@\colorbox{white}{\kern-.1em\scalebox{.7}[1]{否}}}}
\def\textHuoKua {\makebox[\ccwd]{灿\kern-.6em\fboxsep\z@\colorbox{white}{\kern-.1em\scalebox{.7}[1]{夸}}}}

\endinput
%%
%% End of file `DMBJ-class.cls'.
