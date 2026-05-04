\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{hnuthesis}
    [2017/07/19 v0.1 HNU thesis template]

% ============================================================================
% 第1部分: 类声明与选项定义
% ============================================================================
% 定义论文类型：0=博士, 1=硕士, 2=学士
\newcount\hnu@degree@type
\hnu@degree@type=0  % 默认博士
\newif\if@hnu@numerical % 判断是否为数字引用格式
\newif\if@hnu@super % 判断是否为上标引用格式
\newif\if@hnu@pdf % 判断是否生成PDF文件

% 定义选项
\DeclareOption{doctor}{\hnu@degree@type=0}     % 博士学位论文
\DeclareOption{master}{\hnu@degree@type=1}     % 硕士学位论文
\DeclareOption{bachelor}{\hnu@degree@type=2}   % 学士学位论文
\DeclareOption{print}{\@hnu@pdffalse} % 定义选项print，表示打印模式，不生成PDF文件
\DeclareOption{pdf}{\@hnu@pdftrue}  % 定义选项pdf，表示生成PDF文件
\DeclareOption{super}{\@hnu@numericaltrue\@hnu@supertrue} % 定义选项super，启用数字引用并使用上标显示
\DeclareOption{numbers}{\@hnu@numericaltrue\@hnu@superfalse}  % 定义选项numbers，启用数字引用，但不使用上标显示
\DeclareOption{authoryear}{\@hnu@numericalfalse}  % 定义选项authoryear，使用作者-年份引用格式
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}  % 所有其他未定义的选项都传递给ctexbook类
\ExecuteOptions{doctor,chinese,print,super} % 执行默认选项：博士论文、中文、打印模式、上标引用
\ProcessOptions\relax % 处理所有选项

% ============================================================================
% 第2部分: 类加载
% ============================================================================
\if@hnu@pdf
    \PassOptionsToClass{oneside}{book}  % PDF 模式下走单面排版
\fi
\PassOptionsToPackage{no-math}{fontspec}  % 让 fontspec 不接管数学字体
\LoadClass[UTF8, a4paper, oneside, zihao=-4]{ctexbook}[2015/05/14]
\RequirePackage{etoolbox}
% ctex 2.0 之前的接口不兼容，必须升级
\@ifclasslater{ctexbook}{2015/05/14}{}{%
    \ClassError{hnuthesis}{%
        Requiring ctex 2.0 or later version!\MessageBreak
        Please update the package using your\MessageBreak
        TeX package manager or from CTAN
    }{%
        See logs for more details.
    }
}

% ============================================================================
% 第3部分: 配置参数管理
% ============================================================================
% 页面几何参数
\def\hnu@page@top{2.5cm}           % 正文页面上边距
\def\hnu@page@bottom{2.5cm}        % 正文页面下边距
\def\hnu@page@left{2.5cm}        % 正文页面左边距
\def\hnu@page@right{2.5cm}       % 正文页面右边距
\def\hnu@page@headheight{0.4cm}   % 页眉高度
\def\hnu@page@headsep{1.45cm}    % 页眉与正文距离
\def\hnu@page@footskip{1.1cm}     % 页脚与正文距离

% 封面几何参数
\def\hnu@cover@top{3.8cm}        % 封面页面上边距
\def\hnu@cover@bottom{3.8cm}     % 封面页面下边距
\def\hnu@cover@left{3.2cm}       % 封面页面左边距
\def\hnu@cover@right{3.2cm}      % 封面页面右边距
\def\hnu@cover@headsep{0.8cm}    % 封面页眉与正文距离
\def\hnu@cover@footskip{0.8cm}   % 封面页脚与正文距离

% 声明页几何参数
\def\hnu@statement@top{2.5cm}     % 声明页上边距
\def\hnu@statement@bottom{2.5cm}   % 声明页下边距
\def\hnu@statement@left{2.5cm}   % 声明页左边距
\def\hnu@statement@right{2.5cm}  % 声明页右边距

% 字体大小参数（bp）
\def\hnu@font@normal{12bp}        % 正文字体大小（小四）
\def\hnu@font@normal@leading{22bp}   % 正文字体行距（固定值 22 磅）
\def\hnu@font@small{10.5bp}         % 小号字体大小（五号）
\def\hnu@font@small@leading{20bp} % 小号字体行距
\def\hnu@font@footnote{9bp}         % 脚注字体大小
\def\hnu@font@footnote@leading{15bp}% 脚注字体行距
\def\hnu@font@toc@page{12bp}      % 目录页码字体大小
\def\hnu@font@toc@page@leading{12bp}% 目录页码字体行距
\def\hnu@font@header{10.5bp}        % 页眉页脚字体大小

% 标题字体大小
\def\hnu@font@chapter{18bp}       % 章标题
\def\hnu@font@section{15bp}       % 节标题
\def\hnu@font@subsection{12bp}    % 副节标题
\def\hnu@font@subsubsection{12bp}% 副副节标题
\def\hnu@font@caption{10.5bp}    % 图表标题

% 章节标题字间距调整参数（根据标题字数动态调整）
\def\hnu@title@ziju@two{2}       % 2字标题字间距
\def\hnu@title@ziju@three{1}      % 3字标题字间距
\def\hnu@title@ziju@four{0.5}     % 4字标题字间距

% ============================================================================
% 第4部分: 辅助命令与全局变量
% ============================================================================
% 设置英文字体
\setmainfont{Times New Roman} % 设置正文字体为Times New Roman
\setsansfont{Arial} % 设置无衬线字体为Arial
\setmonofont{Courier New} % 设置等宽字体为Courier New
% 设置中文字体（使用系统字体名，Windows 徽标键 + R -> fc-list :lang=zh 查看可用字体）
\setCJKmainfont{SimSun}[AutoFakeBold=true] % 设置中文字体为宋体，加粗效果为伪粗体
\setCJKsansfont{SimHei} % 设置中文无衬线字体为黑体

% 加载hyperref包，设置PDF元数据、超链接颜色、超链接样式
\RequirePackage{hyperref}
% 配置hyperref的参数
\hypersetup{
    bookmarksopen=true, % 打开PDF文件时书签栏默认展开
    bookmarksnumbered=true, % 书签条目带有编号
    bookmarksopenlevel=1, % 书签展开到一级标题
    CJKbookmarks=true,  % 支持中文书签
    pdfborder=0 0 0,  % 链接无边框
    unicode=true, % 支持unicode编码
    linktoc=all,  % 目录中的章节和小节名都添加超链接
}

% 如果启用了PDF选项，则配置超链接颜色
\if@hnu@pdf
    \hypersetup{
        colorlinks=true,  % 启用彩色链接
        allcolors=blue, % 所有链接的颜色为蓝色
    }
\fi

% 在文档开始时设置PDF标题和作者
\AtBeginDocument{
    \hnu@split@title  % 解析标题，分离 \\ 换行位置
    \hypersetup{
        pdftitle={\hnu@title@lineA\hnu@title@lineB},  % 使用无 \\ 的拼接标题
        pdfauthor={\hnu@author}
    }
}

% 加载xparse宏包，用于定义高级命令
\RequirePackage{xparse}

% 定义新命令\setfontsize，用于设置字体大小和行间距，{mo}表示该命令接收一个必需参数和一个可选参数
\NewDocumentCommand\setfontsize{mo}
    % \IfValueTF用于检测可选参数#2是否存在
    {\IfValueTF{#2}
        {\fontsize{#1}{#2}  % 如果提供了行距#2，则设置字体大小为#1，行距为#2
    }{
        \fontsize{#1}{2\dimexpr#1}  % 如果未提供行距#2，默认行距为2倍字体大小#1
    }
    \linespread{1}  % 设置行距为1.0倍
    \selectfont\relax % 应用所选字体设置
}

% 定义新命令\zhspace，用于生成宽度为#1倍中文字符宽度的水平空白
\newcommand\zhspace[1][1]{\hspace{#1\ccwd}} % \ccwd表示中文字符宽度（chinese character width）

% 定义新命令\hnu@underline，生成带有固定宽度的下划线
\newcommand\hnu@underline[2][6em]{%
    \hskip1pt\underline{\hb@xt@ #1{\hss#2\hss}}\hskip3pt\relax % #1为下划线长度的可选参数，默认为6em，#2为下划线内容
}

% 定义新宏命令hnu@define@term，用于生成带有前缀hun@的全局变量，#1表示要定义的变量名称。通过动态创建带有hnu@前缀的命令和存储值，是这些命令可以在其他地方被调用
\def\hnu@define@term#1{
    \expandafter\gdef\csname #1\endcsname##1{ % 使用\expandafter来展开#1的值并生成对应命令
        \expandafter\gdef\csname hnu@#1\endcsname{##1}  % 创建一个全局变量hnu@#1，并将参数##1赋值给该变量
    }
    \csname #1\endcsname{}  % 立即调用该命令，并初始化为空值
}
% 通过 \hnu@define@term{xxx} 生成 \xxx 命令与 \hnu@xxx 全局变量。
% 用户在 main.tex 中调用 \xxx{...} 设置内容，类内通过 \hnu@xxx 取值。
\hnu@define@term{hnucode}        % 学校代号
\hnu@define@term{hnuname}        % 学校名称
\hnu@define@term{degree}         % 学位类型
\hnu@define@term{title}          % 论文标题
\hnu@define@term{clc}            % 中图分类号
\hnu@define@term{secrettext}     % 密级
\hnu@define@term{author}         % 作者姓名
\hnu@define@term{authorid}       % 学号
\hnu@define@term{class}          % 班级
\hnu@define@term{college}        % 学院
\hnu@define@term{major}          % 专业
\hnu@define@term{workon}         % 研究方向
\hnu@define@term{supervisor}     % 导师姓名
\hnu@define@term{cosupervisor}   % 第二导师 / 实践导师
\hnu@define@term{submitdate}     % 提交日期
\hnu@define@term{defensedate}    % 答辩日期
\hnu@define@term{chair}          % 答辩委员会主席
\hnu@define@term{entitle}        % 英文标题
\hnu@define@term{enauthor}       % 英文作者姓名
\hnu@define@term{enmajor}        % 英文专业
\hnu@define@term{endoctor}       % 英文学位（博士）
\hnu@define@term{enmaster}       % 英文学位（硕士）
\hnu@define@term{enbachelor}     % 英文学位（学士）
\hnu@define@term{enhnuname}      % 英文学校名称
\hnu@define@term{ensupervisor}   % 英文导师姓名
\hnu@define@term{endate}         % 英文日期

% ============================================================================
% 第5部分: 题注与引用名称
% ============================================================================
% 根据论文类型设置论文名称
% \hnu@degree@type: 0=博士, 1=硕士, 2=学士
\ifcase\hnu@degree@type
  \newcommand\hnu@thesisname{博士学位论文}%
  \newcommand\hnu@yemeiname{\hnu@hnuname 博士学位论文}%
  \newcommand\hnu@enthesisname{A Dissertation Submitted for the Doctor Degree}%
\or
  \newcommand\hnu@thesisname{硕士学位论文}%
  \newcommand\hnu@yemeiname{\hnu@hnuname 硕士学位论文}%
  \newcommand\hnu@enthesisname{A Thesis Submitted for the Master Degree}%
\or
  \newcommand\hnu@thesisname{毕业设计（论文）}%
  \newcommand\hnu@yemeiname{\hnu@title}%
  \newcommand\hnu@enthesisname{}%
\fi

% 表格：
% 三线表
\RequirePackage{booktabs} % 加载booktabs宏包，用于创建三线表（toprule、midrule、bottomrule）
\RequirePackage{multirow} % 加载multirow宏包，用于在表格中创建跨行单元格

% 题注、标题
% 重定义插图和附表的索引标题名称
\renewcommand\listfigurename{插图索引}  % 将"List of Figures" 重命名为"插图索引"
\renewcommand\listtablename{附表索引}   % 将"List of Tables" 重命名为"附表索引"
% 定义其他文档部分的名称
\newcommand\hnu@notesname{\textbf{注}：}  % 定义注释部分的名称，粗体显示为“注：”
\newcommand\hnu@enabstractname{Abstract}  % 定义英文摘要部分的名称为“Abstract”
\newcommand\hnu@abstractname{摘\quad 要}  % 定义中文摘要部分的名称为“摘  要”
\newcommand\hnu@acknowledgementsname{致\quad 谢}  % 定义致谢部分的名称为“致  谢”
\newcommand\hnu@tocname{目\quad 录}   % 定义目录部分的名称为“目  录”
\newcommand\hnu@summaryname{总结与展望}   % 定义总结与展望部分的名称为“总结与展望”
\newcommand\hnu@notationname{符号说明}    % 定义符号说明部分的名称为“符号说明”
% 自定义 \autoref 引用前缀（中文）
\def\equationautorefname~#1\null{公式~(#1)\null}%
\def\footnoteautorefname{脚注}%
\def\itemautorefname~#1\null{第~#1~项\null}%
\def\figureautorefname{图}%
\def\tableautorefname{表}%
\def\partautorefname~#1\null{第~#1~部分\null}%
\def\appendixautorefname{}%
\def\chapterautorefname~#1\null{第~#1~章\null}%
\def\sectionautorefname~#1\null{第~#1~节\null}%
\def\subsectionautorefname~#1\null{第~#1~小节\null}%
\def\subsubsectionautorefname~#1\null{第~#1~小小节\null}%
\def\paragraphautorefname~#1\null{第~#1~段\null}%
\def\subparagraphautorefname~#1\null{第~#1~小段\null}%
\def\theoremautorefname{定理}%
\def\pageautorefname~#1\null{第~#1~页\null}%

% ============================================================================
% 第6部分: 页面与列表设置
% ============================================================================
% 页面尺寸与边距
\RequirePackage{geometry}
\geometry{
    paper=a4paper,
    top=\hnu@page@top, bottom=\hnu@page@bottom,
    left=\hnu@page@left, right=\hnu@page@right,
    headheight=\hnu@page@headheight,
    headsep=\hnu@page@headsep,
    footskip=\hnu@page@footskip
}

% 页眉页脚样式
\RequirePackage{fancyhdr}
\renewcommand{\headrulewidth}{0.4pt}
\fancypagestyle{hnu@headings}{%
  \fancyhf{}%
    \fancyhead[CO]{\setfontsize{\hnu@font@header}\hnu@yemeiname}
    \fancyfoot[C]{\setfontsize{\hnu@font@header}\thepage}
  \fancyheadoffset[LO,LE]{3mm}                      % 奇数页页眉左偏 3mm
  \fancyheadoffset[RO,RE]{-3mm}                     % 偶数页页眉右偏 3mm

  % 重定义页眉横线：粗 0.5pt，紧贴文本
  \def\headrule{
    \if@fancyplain\let\headrulewidth\plainheadrulewidth\fi%
    \hrule\@height 0.5pt \@width\headwidth
    \vskip-2\headrulewidth
    \vskip-1pt
  }
    \vspace{7mm}                                    % 页眉与正文的垂直间距
}%

% 符号说明页使用空白页脚
\fancypagestyle{hnu@notation}{\fancyfoot{}}
\pagestyle{hnu@headings}
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}

% 双面排版时，cleardoublepage 在偶数页插入空白以便下一章从奇数页开始
\renewcommand*{\cleardoublepage}{
    \clearpage
    \if@twoside
        \ifodd\c@page
        \else
            \hbox{}
            \thispagestyle{empty}
            \newpage
            \if@twocolumn
                \hbox{}
                \newpage
            \fi
        \fi
    \fi
}

% 前言部分使用大写罗马数字页码
\g@addto@macro\frontmatter{%
    \pagenumbering{Roman}%
}

% 主体部分使用阿拉伯数字页码，自奇数页开始
\renewcommand\mainmatter{%
  \cleardoublepage
  \pagenumbering{arabic}%
  \@mainmattertrue
}

% 列表样式：左缩进 3em，零间距
\RequirePackage{enumitem}
\setitemize{leftmargin=3em, itemsep=0em, partopsep=0em, parsep=0em, topsep=-0em}
\setenumerate{leftmargin=3em, itemsep=0em, partopsep=0em, parsep=0em, topsep=0em}

% ============================================================================
% 第7部分: 章节格式与书签
% ============================================================================
% 章节、段落、页眉、页脚
\renewcommand\chapter{%
  \if@openright\cleardoublepage\else\clearpage\fi % 判断是否为openright模式，如果是，则章节从右页开始
  \setlength{\baselineskip}{\hnu@font@normal@leading}
  \global\@topnum\z@  % 禁止在章节页顶部放置浮动体
  \@afterindenttrue   % 章节后的第一段缩进
  \secdef\@chapter\@schapter  % 使用secdef定义章节命令，分别处理带编号和不带编号的章节
}

% 加载pifont宏包，用于使用符号字体
\RequirePackage{pifont}
% 定义自定义命令hnu@textcircled，显示带圈的数字
\def\hnu@textcircled#1{%
    % 如果当前页脚的编号大于9，则报错
    \ifnum\value{#1} >9
        \ClassError{hnuthesis}%
            {Too many footnotes in this page.}{Keep footnote less than 10.}
    \fi
    % 使用ding命令生成带圈的数字，编号通过计算公式实现
    \ding{\the\numexpr\value{#1}+191\relax}
}

% 章节标题字距动态调整：标题字数少时增加字距，使视觉宽度接近
% 2 字 -> ziju 2，3 字 -> 1，4 字 -> 0.5，5 字及以上保持默认
\RequirePackage{stringstrings}
\newcounter{titlelength}
\newcommand\spacetitle[1]{%
    \@getstringlength{#1}{titlelength}%
    \ifnum\thetitlelength=2
        {\ziju{2}#1}
    \else%
        \ifnum\thetitlelength=3
            {\ziju{1}#1}
        \else%
            \ifnum\thetitlelength=4
                {\ziju{0.5}#1}
            \else
                #1%
            \fi
        \fi
    \fi
}

\setcounter{secnumdepth}{5}                          % 编号深度到 subparagraph

% 章 / 节 / 小节等格式
\ctexset{
    chapter = {
        format      = \centering\sffamily\bfseries\setfontsize{\hnu@font@chapter},
        nameformat  = {},
        number      = \thechapter,
        aftername   = \hspace{\ccwd},
        beforeskip  = -1.5em,                                 % 章标题前留白
        afterskip   = 1.5em,                                  % 章标题后留白
    },
    section = {
        format     = \bf\sffamily\setfontsize{\hnu@font@section},
        aftername  = \hspace{\ccwd},
        beforeskip = 12pt,
        afterskip  = 12pt,
    },
    subsection = {
        format     = \bf\sffamily\setfontsize{\hnu@font@subsection},
        aftername  = \hspace{\ccwd},
        beforeskip = 6pt,
        afterskip  = 6pt,
    },
    subsubsection = {
        format     = \sffamily\setfontsize{\hnu@font@normal},
        number     = (\arabic{subsubsection}),                % 编号形如 (1)
        beforeskip = 6pt,
        afterskip  = 6pt,
    },
    paragraph = {
        format    = \sffamily\setfontsize{\hnu@font@normal},
        number    = (\arabic{paragraph}),
        aftername = \hspace{\ccwd},
    },
    subparagraph = {
        format    = \sffamily\setfontsize{\hnu@font@normal},
        number    = \hnu@textcircled{subparagraph},           % 带圈数字
        aftername = \hspace{\ccwd},
    },
}

% \hnu@chapter[bookmark]{title}
%   生成不带编号的章节，并在 PDF 书签中以 [bookmark] 显示（缺省时与 title 相同）。
%   摘要、目录、致谢、参考文献等都通过它统一接入书签。
\newcounter{hnu@pdfbookmark}
\NewDocumentCommand\hnu@chapter{o m}{%
  \if@openright\cleardoublepage\else\clearpage\fi%
  \addtocounter{hnu@pdfbookmark}\@ne
  \IfValueTF{#1}{%
    \pdfbookmark[0]{#1}{hnuchapter.\thehnu@pdfbookmark}%
    \chaptermark{#1}%
  }{%
    \pdfbookmark[0]{#2}{hnuchapter.\thehnu@pdfbookmark}%
    \chaptermark{#2}%
  }%
  \chapter*{#2}
}

% ============================================================================
% 第8部分: 封面与声明
% ============================================================================

% 封面
% 重定义 \maketitle命令，负责生成论文的封面部分
\renewcommand\maketitle{%
    % 根据论文类型选择不同的封面
    % \hnu@degree@type: 0=博士, 1=硕士, 2=学士
    \newgeometry{
        top=\hnu@cover@top, bottom=\hnu@cover@bottom,
        left=\hnu@cover@left, right=\hnu@cover@right,
        headheight=0cm,
        headsep=\hnu@cover@headsep,
        footskip=\hnu@cover@footskip
    }
    \pagenumbering{gobble}  % 封面禁用页码

    \ifnum\hnu@degree@type<2\relax
      % 博士 / 硕士：三页中英文封面 + 原创性声明 / 版权授权
      \make@cntitle@first  \clearpage
      \make@entitle        \clearpage
      \make@cntitle@second \clearpage
      \restoregeometry
      \make@statement
    \else
      % 学士：单页封面 + 诚信声明
      \make@bachelor@cover \clearpage
      \restoregeometry
      \make@bachelor@statement
    \fi
}

% 定义新命令 \hnu@supervisorline，生成导师信息行
\newcommand\hnu@supervisorline{%
    % 如果联合导师为空，则只显示一位导师信息
    \ifx\hnu@encosupervisor\@empty%
        Supervisor: \hnu@ensupervisor%
    % 如果联合导师不为空，则显示两位导师信息
    \else%
        Supervisors: \hnu@ensupervisor, \hnu@encosupervisor%
    \fi
}

% 加载TikZ宏包，用于绘制图形
\RequirePackage{tikz}
% 定义新命令 \vpostext，垂直定位文本
\newcommand\vpostext[2]{%
    \tikz[remember picture,overlay]%
        % yshift指定垂直偏移量#1，文本#2放置在页面顶部（current page.north）的下方
        \node [yshift=-#1] at (current page.north) [below,align=flush center]%
            %使用parbox创建一个居中的文本框，文本框宽度为\textwidth
            {\parbox{\textwidth}{\centering#2}};
}

% 定义新命令 \linetext，生成带下划线的文本
\newcommand\linetext[3]{%
  \underline{\makebox[#1][#2]{#3}}  % 使用makebox生成固定宽度的文本框，添加下划线
}

% 中文封面
% 加载tabularx宏包，用于在表格中使用可调整列宽的X列类型
\RequirePackage{tabularx}

% 封面信息表共享长度：标签宽 \@tw / 内容宽 \@cw，每张封面通过 \setlength 调整
\newlength{\@tw}
\newlength{\@cw}

% 封面信息表行格式：
%   \hnu@coverrow{标签}{内容}   中文行（标签左对齐两端拉伸）
%   \hnu@coverrowR{标签}{内容}  英文行（标签右对齐）
\newcommand\hnu@coverrow[2]{%
    \makebox[\@tw][s]{\sffamily\textbf{#1}} & \linetext{\@cw}{c}{#2} \\%
}
\newcommand\hnu@coverrowR[2]{%
    \makebox[\@tw][r]{\sffamily\textbf{#1}} & \linetext{\@cw}{c}{#2} \\%
}
% 博士/硕士学位论文中文封面第一页
% 布局：右上角密级与中图分类号；居中学校LOGO、论文类型、论文标题；
%       下方研究生信息表（研究生、导师、学科、研究方向）；底部提交日期
\newcommand\make@cntitle@first{%
    \begin{titlepage}%
        \phantomsection
        \pdfbookmark[0]{封面}{titlepage}

        % 右上角：密级与中图分类号
        \tikz[remember picture,overlay]%
          \node [xshift=2.5cm,yshift=-2.5cm] at (current page.north west)%
            [below right,align=left] {%
                \setlength{\@tw}{75pt}   % 标签宽度
                \setlength{\@cw}{3cm}    % 内容宽度
                \setfontsize{\hnu@font@normal}%
                \begin{tabularx}{\linewidth}{lrl}%
                    \makebox[8.5cm][c]{\qquad} & \hnu@coverrow{密级：}{\hnu@secrettext}
                    \makebox[8.5cm][c]{\qquad} & \hnu@coverrow{中图分类号：}{\hnu@clc}
                \end{tabularx}
            };%

        % 学校LOGO（距页面顶部 6cm）
        \vpostext{6cm}{\includegraphics[height=2cm]{figures/hnie-logo.png}}%
        % 论文类型标题（距页面顶部 8.3cm，22pt 加粗无衬线）
        \vpostext{8.3cm}{\bf\sffamily\setfontsize{22pt}\hnu@thesisname}%
        % 论文标题（距页面顶部 12cm，26pt 加粗无衬线）
        \vpostext{12cm}{\bf\sffamily\setfontsize{26pt}\hnu@title}%

        % 研究生信息表（距页面顶部 18cm）
        \tikz[remember picture,overlay]
          \node [xshift=5cm,yshift=-18cm] at (current page.north west)%
            [below right,align=left] {%
                \setlength{\@tw}{94pt}
                \setlength{\@cw}{6.4cm}
                \setfontsize{14pt}%
                \begin{tabular}{@{}l@{\hspace{\ccwd}}l@{}}%
                    \hnu@coverrow{研究生：}{\hnu@author}
                    \hnu@coverrow{导师：}{\hnu@supervisor}
                    \hnu@coverrow{学科：}{\hnu@major}
                    \hnu@coverrow{研究方向：}{\hnu@workon}
                \end{tabular}
            };%

        % 论文提交日期（距页面顶部 25cm）
        \vpostext{25cm}{\bf\sffamily\setfontsize{\hnu@font@normal}\hnu@submitdate}%
    \end{titlepage}
}


% 博士/硕士学位论文中文封面第二页
% 布局：顶部论文标题；中部详细信息表（学位类型、作者、学号、学科、研究方向、导师、学院、提交日期）
\newcommand\make@cntitle@second{%
  \begin{titlepage}%
      % 论文标题（距页面顶部 6cm，22pt 加粗无衬线）
      \vpostext{6cm}{\bf\sffamily\setfontsize{22pt}\hnu@title}%

      % 详细信息表（距页面顶部 14cm）
      \tikz[remember picture,overlay]
        \node [xshift=3.2cm,yshift=-14cm] at (current page.north west)%
          [below right,align=left] {%
              \setlength{\@tw}{128pt}
              \setlength{\@cw}{8cm}
              \setfontsize{14pt}%
              \begin{tabular}{@{}l@{\hspace{\ccwd}}l@{}}%
                  \hnu@coverrow{学位类型}{\hnu@degree}
                  \hnu@coverrow{作者姓名}{\hnu@author}
                  \hnu@coverrow{作者学号}{\hnu@authorid}
                  \hnu@coverrow{学科（专业学位类别）}{\hnu@major}
                  \hnu@coverrow{研究方向（专业领域）}{\hnu@workon}
                  \hnu@coverrow{导师姓名及职称}{\hnu@supervisor}
                  \hnu@coverrow{实践导师姓名及职称}{\hnu@cosupervisor}
                  \hnu@coverrow{所在学院}{\hnu@college}
                  \hnu@coverrow{论文提交日期}{\hnu@submitdate}
              \end{tabular}
          };%
  \end{titlepage}
}
% 博士/硕士学位论文英文封面
% 布局：顶部学位说明文字；英文论文标题；下方作者与导师信息表
\newcommand\make@entitle{%
    \begin{titlepage}%
        \phantomsection
        \pdfbookmark[0]{Title Page}{entitlepage}

        % 学位说明文字（距页面顶部 3.9cm，15pt）
        \vpostext{3.9cm}{\setfontsize{15pt}\hnu@enthesisname}%
        % 英文论文标题（距页面顶部 5.9cm，22pt 加粗）
        \vpostext{5.9cm}{\setfontsize{22pt}\textbf{\hnu@entitle}}%

        % 作者与导师信息表（距页面顶部 18cm）
        \tikz[remember picture,overlay]
          \node [xshift=5.5cm,yshift=-18cm] at (current page.north west)%
            [below right,align=left] {%
                \setlength{\@tw}{94pt}
                \setlength{\@cw}{6.4cm}
                \setfontsize{14pt}%
                \begin{tabular}{@{}l@{\hspace{\ccwd}}l@{}}%
                    \hnu@coverrowR{Candidate: }{\hnu@enauthor}
                    \hnu@coverrowR{Supervisor and Rank: }{\hnu@ensupervisor}
                \end{tabular}
            };%
    \end{titlepage}
}

% 博士/硕士学位论文原创性声明正文
\newcommand{\hnu@declaretext}{%
本人郑重声明：所呈交的论文是本人在导师的指导下独立进行研究所取得的研究成果。 除了文中特别加以标注引用的内容外，本论文不包含任何其他个人或集体已经发表或撰写的成果作品。对本文的研究做出重要贡献的个人和集体，均已在文中以明确方式标明。本人完全意识到本声明的法律后果由本人承担。
}

% 博士/硕士学位论文版权使用授权书正文
\newcommand{\hnu@authorization}{%
本学位论文作者完全了解学校有关保留、使用学位论文的规定，同意学校保留并向国家有关部门或机构送交论文的复印件和电子版，允许论文被查阅和借阅。本人授权湖南工程学院可以将本学位论文的全部或部分内容编入有关数据库进行检索，可以采用影印、缩印或扫描等复制手段保存和汇编本学位论文。

涉密论文按学校规定处理。
}

% 博士/硕士学位论文原创性声明与版权授权书页
% 布局：原创性声明标题及正文、作者签名行；版权使用授权书标题及正文、作者与导师签名行
\newcommand\make@statement{%
    \begin{titlepage}%
        \phantomsection
        \pdfbookmark[0]{原创性声明}{statement}

        \newgeometry{
            left=\hnu@statement@left, right=\hnu@statement@right,
            top=\hnu@statement@top, bottom=\hnu@statement@bottom
        }
        \thispagestyle{plain}
        \pagenumbering{gobble}
        \setcounter{page}{1}
        \setfontsize{\hnu@font@normal}[\hnu@font@normal@leading]
        \vspace*{-0.15cm}

        % 原创性声明标题（18pt，居中，加粗）
        \begin{center}
          \sffamily\setfontsize{18pt}
          \textbf{学位论文原创性声明}
        \end{center}
        \vskip 0.3cm

        % 原创性声明正文
        \hnu@declaretext\par
        \vskip 1cm

        % 作者签名行
        作者签名：\qquad\qquad\qquad\qquad\qquad\quad 日期：\qquad\quad 年\qquad 月\qquad 日
        \vskip 1cm

        % 版权使用授权书标题（18pt，居中，加粗）
        \begin{center}
          \sffamily\setfontsize{18pt}
          \textbf{学位论文版权使用授权书}
        \end{center}
        \vskip 0.3cm

        % 版权使用授权书正文
        \hnu@authorization\par
        \vskip 1cm

        % 作者与导师签名行
        作者签名：\qquad\qquad\qquad\qquad\qquad\quad 日期：\qquad\quad 年\qquad 月\qquad 日

        导师签名：\qquad\qquad\qquad\qquad\qquad\quad 日期：\qquad\quad 年\qquad 月\qquad 日
        \restoregeometry
    \end{titlepage}%
}

% 学士学位论文封面专用长度变量
\newlength{\@btw}
\newlength{\@bcw}
\setlength\@btw{2.5cm}
\setlength\@bcw{11.5cm}

% 标题换行标记：在 main.tex 中用 \titlebr 指定封面标题的换行位置
% 用法：\title{第一行内容\titlebr 第二行内容}
% 若标题不含 \titlebr，则全部内容在第一行，第二行下划线留空
\newcommand\titlebr{}    % 用户命令：标题换行标记
\def\hnu@title@lineA{}   % 初始化：标题第一行
\def\hnu@title@lineB{}   % 初始化：标题第二行

% 第一步：去掉 #2 末尾多余的 \titlebr（由追加的哨兵引入）
\def\hnu@title@strip@br#1\titlebr#2\hnu@strip@end{%
  \def\hnu@title@lineB{#1}%
}
% 第二步：在第一个 \titlebr 处拆分，#2 会含尾部多余的 \titlebr，交给 strip 处理
\def\hnu@title@split@helper#1\titlebr#2\hnu@split@end{%
  \def\hnu@title@lineA{#1}%
  \hnu@title@strip@br#2\titlebr\hnu@strip@end%
}
\newcommand\hnu@split@title{%
  \expandafter\hnu@title@split@helper\hnu@title\titlebr\hnu@split@end%
}

% 学士学位论文封面（单页）
\newcommand\make@bachelor@cover{%
  \begin{titlepage}%
    \phantomsection
    \pdfbookmark[0]{封面}{titlepage}

    % 解析题目，支持 \titlebr 手动换行
    \hnu@split@title

    % 学校LOGO
    \vpostext{3.5cm}{\includegraphics[height=1.8cm]{figures/hnie-logo.png}}

    % 论文类型标题
    \vpostext{7cm}{\bf\sffamily\setfontsize{36pt}\hnu@thesisname}

    % 论文标题（两行下划线，用 \titlebr 指定换行位置）
    \tikz[remember picture,overlay]
      \node [xshift=3cm,yshift=-12cm] at (current page.north west)%
        [below right,align=left]{%
          \setfontsize{16pt}[36bp]%
          \begin{tabular}{@{}l@{\hspace{0em}}l@{}}%
            \sffamily\textbf{题\qquad 目：} & \linetext{\@bcw}{c}{\hnu@title@lineA} \\%
            \sffamily\textbf{\qquad\quad} & \linetext{\@bcw}{c}{\hnu@title@lineB} \\%
          \end{tabular}
        };%

    % 下方信息表格
    \tikz[remember picture,overlay]
      \node [xshift=3cm,yshift=-17cm] at (current page.north west)%
        [below right,align=left]{%
          \setfontsize{16pt}[36bp]%
          \begin{tabular}{@{}l@{}}
            \sffamily\textbf{学院：}\linetext{12.7cm}{c}{\hnu@college} \\%
            \sffamily\textbf{专业：}\linetext{4.2cm}{c}{\hnu@major}%
            \hspace{0.2em}\sffamily\textbf{班级：}\linetext{1.2cm}{c}{\hnu@class}%
            \hspace{0.2em}\sffamily\textbf{学号：}\linetext{3.33cm}{c}{\hnu@authorid} \\%
            \sffamily\textbf{学生姓名：}\linetext{\@bcw}{c}{\hnu@author} \\%
            \sffamily\textbf{导师姓名：}\linetext{\@bcw}{c}{\hnu@supervisor} \\%
            \sffamily\textbf{完成日期：}\linetext{\@bcw}{c}{\hnu@submitdate}%
          \end{tabular}
        };
  \end{titlepage}%
}

% 学士学位论文诚信声明页
\newcommand\make@bachelor@statement{%
  \begin{titlepage}%
    \phantomsection
    \pdfbookmark[0]{诚信声明}{statement}

    \newgeometry{
      left=\hnu@statement@left, right=\hnu@statement@right,
      top=\hnu@statement@top, bottom=\hnu@statement@bottom
    }
    \thispagestyle{plain}
    \pagenumbering{gobble}
    \setfontsize{\hnu@font@normal}

    % 声明标题（小二号 18pt，黑体）
    \begin{center}
      \sffamily\setfontsize{18pt}诚信声明
    \end{center}
    \vskip 1cm

    % 声明正文（小三号 15pt 粗体；条目间距 0.5em）
    \setfontsize{15pt}\bfseries
    \setlength{\parskip}{0.5em}
    \ziju{0.05}
    本人声明：

    1、本人所呈交的毕业设计（论文）是在老师指导下进行的研究工作及取得的研究成果；

    2、据查证，除了文中特别加以标注和致谢的地方外，毕业设计（论文）中不包含其他人已经公开发表过的研究成果，也不包含为获得其他教育机构的学位而使用过的材料；

    3、我承诺，本人提交的毕业设计（论文）中的所有内容均真实、可信。

    \vspace{2cm}
    \begin{flushright}
      作者签名：\hspace{4cm} 日期：\hspace{2cm} 年\hspace{1cm} 月\hspace{1cm} 日
    \end{flushright}

    \restoregeometry
  \end{titlepage}%
}



% ============================================================================
% 第9部分: 摘要、目录与符号说明
% ============================================================================
% 摘要、关键字
% 定义中文摘要环境
% 布局：论文题目居中；“摘要：”加粗不缩进，后接正文内容；末尾接 \keywords{}
\newenvironment{abstract}{%
    \clearpage
    \pagenumbering{roman}
    \setcounter{page}{1}
    \addtocontents{toc}{\protect\contentsline{chapter}{\hnu@abstractname}{\thepage}{}}%
    % 论文题目（居中，黑体，小二 18pt，固定行距 22pt，段前段后各 1 行）
    \vspace*{\hnu@font@normal@leading}
    \begin{center}
      {\sffamily\bfseries\setfontsize{18pt}[\hnu@font@normal@leading]\hnu@title}
    \end{center}
    \vskip \hnu@font@normal@leading
    % 摘要正文字体（小四 12pt，固定行距）
    \setfontsize{\hnu@font@normal}[\hnu@font@normal@leading]%
    \ziju{0.05}
    % “摘要：”标签（黑体加粗，不缩进），后接正文内容
    \noindent{\sffamily\bfseries 摘要：}%
}{}

% 定义英文摘要环境
% 布局：论文题目居中；“Abstract: ”加粗不缩进，后接正文内容；末尾接 \enkeywords{}
\newenvironment{enabstract}{%
    \clearpage
    \pagenumbering{roman}
    \addtocontents{toc}{\protect\contentsline{chapter}{\hnu@enabstractname}{\thepage}{}}%
    % 论文题目（居中，黑体，小二 18pt，固定行距 22pt，段前段后各 1 行）
    \vspace*{\hnu@font@normal@leading}
    \begin{center}
      {\sffamily\bfseries\setfontsize{18pt}[\hnu@font@normal@leading]\hnu@entitle}
    \end{center}
    \vskip \hnu@font@normal@leading
    % 英文摘要正文字体（小四 12pt，固定行距）
    \setfontsize{\hnu@font@normal}[\hnu@font@normal@leading]%
    % "Abstract: "标签（加粗，不缩进），后接正文内容
    \noindent{\bfseries Abstract: }%
}{}

% 定义中文关键词命令
\newcommand\keywords[1]{%
  \par\phantom{empty}\par\noindent\hangindent=4\ccwd\relax% % 设置缩进4个中文字符宽度，插入关键词部分
  \sffamily\textbf{关键词}：#1} % 使用无衬线字体，加粗显示“关键词”，并输出关键词内容
% 定义英文关键词命令
\newcommand\enkeywords[1]{%
  \par\phantom{empty}\par\noindent\hangindent=5.3em\relax%  % 设置缩进5.3em，插入关键词部分
  \textbf{Key Words}: #1} % 加粗显示“Key Words”，并输出关键词内容

% 定义总结与展望环境
\newenvironment{summary}{%
    \hnu@chapter{\hnu@summaryname}% % 插入“总结与展望”标题
}{}

% 定义致谢环境
\newenvironment{acknowledgements}{%
  \chapter{\hnu@acknowledgementsname}%  % 插入“致谢”标题
}{}

% 目录
\renewcommand\tableofcontents{%
    \cleardoublepage% % 插入分页符，确保目录从新页开始
    \pagenumbering{Roman} % 使用罗马数字作为目录的页码
    \setcounter{tocdepth}{2}  % 设置目录深度为2，即包括章、节、小节
    \hnu@chapter{\hnu@tocname}% % 调用自定义命令\hnu@chapter，插入“目录”标题
    \@starttoc{toc} % 启动目录文件（toc），生成目录内容
}

% 加载titletoc宏包，用于自定义目录格式
\RequirePackage{titletoc}
% 定义目录中的引导符为点线
\newcommand\hnu@leaders{\titlerule*[0.5pc]{$\cdot$}}
  % 定义章级别的目录格式
  \titlecontents{chapter}[0bp]
    {\addvspace{6bp}\bf\sffamily\setfontsize{\hnu@font@normal}[\hnu@font@normal@leading]}
    {\contentspush{\thecontentslabel\unskip\hskip\ccwd\relax}}
    {}{\hnu@leaders\setfontsize{\hnu@font@toc@page}[\hnu@font@toc@page@leading]\contentspage}
  % 定义节级别的目录格式
  \titlecontents{section}
      [2\ccwd]
      {\setfontsize{\hnu@font@normal}[\hnu@font@normal@leading]}
      {\contentspush{\thecontentslabel\hskip\ccwd\relax}}
      {}{\hnu@leaders\setfontsize{\hnu@font@toc@page}[\hnu@font@toc@page@leading]\contentspage}
  % 定义小节级别的目录格式
  \titlecontents{subsection}
      [4\ccwd]
      {\setfontsize{\hnu@font@normal}[\hnu@font@normal@leading]}
      {\contentspush{\thecontentslabel\hskip\ccwd\relax}}
      {}{\hnu@leaders\setfontsize{\hnu@font@toc@page}[\hnu@font@toc@page@leading]\contentspage}

  % 图目录的格式
  \titlecontents{figure}[0bp]
      {\setfontsize{\hnu@font@normal}}
      {\figureautorefname\hspace*{0.5em}\thecontentslabel\quad} % 在图目录中显示图编号及其标题
      {}{\hnu@leaders\contentspage} % 使用引导符显示到页码
  % 表目录的格式
  \titlecontents{table}[0bp]
      {\setfontsize{\hnu@font@normal}}
      {\tableautorefname\hspace*{0.5em}\thecontentslabel\quad}  % 在表目录中显示表编号及其标题
      {}{\hnu@leaders\contentspage} % 使用引导符显示到页码

% 为了让图/表目录另页起，重新定义 \listoffigures 和 \listoftables
\renewcommand\listoffigures{%
    \clearpage  % 插入分页符，确保图目录从新页开始
    \hnu@chapter{\listfigurename}%  % 插入“插入索引”作为章级标题
    \@starttoc{lof}}  % 生成图目录内容
\renewcommand\listoftables{%
    \clearpage % 插入分页符，确保表目录从新页开始
    \hnu@chapter{\listtablename}% % 插入“表目录”作为章级标题
    \@starttoc{lot}}  % 生成表目录内容

% 定义notation环境，用于生成符号说明部分
\newenvironment{notation}{%
    \cleardoublepage % 确保符号说明部分从新页开始
    \thispagestyle{hnu@notation}  % 使用自定义页眉页脚样式 hnu@notation
    \ctexset{chapter/format = \centering\rmfamily\setfontsize{\hnu@font@chapter}} % 设置章标题格式为居中，衬线字体，字号12bp
    \hnu@chapter{\hnu@notationname} % 插入“符号说明”章标题
    \setfontsize{\hnu@font@small}[\hnu@font@small@leading]
    \setlength{\itemsep}{0bp}}{}  % 设置列表项之间的垂直间距为0bp

% ============================================================================
% 第10部分: 字体与图表格式
% ============================================================================
% 以 bp（big point，1/72 inch）为字号单位，便于按号匹配中文字号
\newdimen\bp@ \bp@=1bp

% 正文 12bp / 行距 20bp。display 间距统一 16pt（保留原 \g@addto@macro 行为）
\renewcommand\normalsize{%
  \@setfontsize\normalsize{12\bp@}{20\bp@}%
  \setlength\abovedisplayskip{16pt}%
  \setlength\abovedisplayshortskip{16pt}%
  \setlength\belowdisplayshortskip{16pt}%
  \setlength\belowdisplayskip{16pt}%
  \let\@listi\@listI
}
\normalsize

\renewcommand\small{%
    \@setfontsize\small{10.5\bp@}{17.5\bp@}%
    \abovedisplayskip 10.5\bp@ \@plus3\bp@ \@minus6\bp@
    \abovedisplayshortskip \z@ \@plus3\bp@
    \belowdisplayshortskip 6.5\bp@ \@plus3.5\bp@ \@minus3\bp@
    \def\@listi{\leftmargin\leftmargini
                \topsep 9\bp@ \@plus3\bp@ \@minus5\bp@
                \parsep 4.5\bp@ \@plus2\bp@ \@minus\bp@
                \itemsep \parsep
    }%
    \belowdisplayskip \abovedisplayskip
}

\renewcommand\footnotesize{%
    \@setfontsize\footnotesize{9\bp@}{15\bp@}
    \abovedisplayskip 9\bp@ \@plus2\bp@ \@minus5\bp@
    \abovedisplayshortskip \z@ \@plus3\bp@
    \belowdisplayshortskip 6\bp@ \@plus3\bp@ \@minus3\bp@
    \def\@listi{\leftmargin\leftmargini
                \topsep 6\bp@ \@plus2\bp@ \@minus2\bp@
                \parsep 3\bp@ \@plus2\bp@ \@minus\bp@
                \itemsep \parsep
    }%
    \belowdisplayskip \abovedisplayskip
}

\renewcommand\scriptsize{\@setfontsize\scriptsize{7.5\bp@}{12.5\bp@}}
\renewcommand\tiny{\@setfontsize\tiny{6.5\bp@}{10.83\bp@}}
\renewcommand\large{\@setfontsize\large{15\bp@}{25\bp@}}
\renewcommand\Large{\@setfontsize\Large{18\bp@}{30\bp@}}
\renewcommand\LARGE{\@setfontsize\LARGE{22\bp@}{36.67\bp@}}
\renewcommand\huge{\@setfontsize\huge{24\bp@}{40\bp@}}
\renewcommand\Huge{\@setfontsize\Huge{26\bp@}{43.33\bp@}}

% 段落与数学符号
\setlength{\parindent}{2\ccwd}
\setlength{\parskip}{\z@}
\RequirePackage{upgreek}
\renewcommand\pi{\uppi}                              % 直立体 π
\RequirePackage{amssymb}
\renewcommand\le{\leqslant}                          % ≤ 用斜杠形式
\renewcommand\leq{\leqslant}
\renewcommand\ge{\geqslant}
\renewcommand\geq{\geqslant}
\DeclareMathSizes{10.5bp}{10.5bp}{7.35bp}{5.25bp}    % 文本/显示/上下标/次级

% 浮动体放置阈值
\renewcommand{\topfraction}{.85}
\renewcommand{\bottomfraction}{.65}
\renewcommand\textfraction{.15}
\renewcommand{\floatpagefraction}{.6}

% 图表标题：悬挂格式、小号加粗、标签后空一个中文字宽
\RequirePackage{caption}
\RequirePackage{calc}
\DeclareCaptionLabelSeparator{zhspace}{\hspace{\ccwd}}
\captionsetup{
    format   = hang,
    font     = {small,bf},
    labelsep = zhspace,
}
\captionsetup[figure]{
    position  = bottom,
    aboveskip = 6bp,
    belowskip = {12bp-\intextsep},
}
\captionsetup[table]{
    position  = top,
    aboveskip = 6bp,
    belowskip = 6bp,
}
% \note{...}：图表下方的"注："说明，悬挂缩进 2 字
\newcommand\note[1]{%
    \captionsetup{position = bottom, font = small}
    \caption*{%
        \hangindent=2\ccwd
        \relax
        \hnu@notesname
        \rmfamily
        #1
    }
}

% 脚注：编号为带圈数字、分隔线宽 25%、首行缩进 2 字
\renewcommand{\thefootnote}{\hnu@textcircled{footnote}}
\renewcommand\footnoterule{%
    \kern-3\p@
    \hrule\@width.25\textwidth
    \kern2.6\p@
}
\renewcommand\@makefntext[1]{%
    \parindent 2\ccwd%
    \noindent
    \hb@xt@2\ccwd{\hss\@makefnmark}
    #1
}

% ============================================================================
% 第11部分: 参考文献
% ============================================================================
\RequirePackage[sort&compress]{natbib}

% 三种引用方括号 / 圆括号、连接符、压缩规则
\newcommand\bibstyle@super{\bibpunct{[}{]}{,}{s}{,}{\textsuperscript{,}}}
\newcommand\bibstyle@numbers{\bibpunct{[}{]}{,}{n}{,}{,}}
\newcommand\bibstyle@authoryear{\bibpunct{(}{)}{;}{a}{,}{,}}
\if@hnu@numerical
  \if@hnu@super
    \citestyle{super}
  \else
    \citestyle{numbers}
  \fi
  \bibliographystyle{hnunumerical}%
\else
  \citestyle{authoryear}
  \bibliographystyle{hnuauthoryear}%
\fi

% 以下三处 patch / 重定义都是为了让 prenote / postnote 出现在右括号 *外面*
% 并以上标形式显示（与国标 GB/T 7714 的"[1]^a"风格一致），覆盖 natbib 默认行为。

% \cite[postnote]{...} —— 数字引用主入口
\patchcmd\NAT@citexnum
{%
  \@ifnum{\NAT@ctype=\z@}{%
    \if*#2*\else\NAT@cmt#2\fi
  }{}%
  \NAT@mbox{\NAT@@close}%
}
{%
  \NAT@mbox{\NAT@@close}%
  \@ifnum{\NAT@ctype=\z@}{%
    \if*#2*\else\textsuperscript{#2}\fi
  }{}%
}{}{}

% 上标引用：[1]^postnote
\renewcommand\NAT@citesuper[3]{%
    \ifNAT@swa
        \if*#2*\else#2\NAT@spacechar\fi
        \unskip\kern\p@\textsuperscript{\NAT@@open#1\NAT@@close\if*#3*\else#3\fi}%
    \else
        #1%
    \fi
    \endgroup
}

% 行内数字引用：[1]^postnote
\renewcommand\NAT@citenum[3]{%
    \ifNAT@swa
        \NAT@@open
        \if*#2*\else#2\NAT@spacechar\fi
        #1\NAT@@close
        \if*#3*\else\textsuperscript{#3}\fi
    \else
        #1%
    \fi
    \endgroup
}

% \cite[postnote]{...} —— 通用入口（作者-年份等）
\patchcmd{\NAT@citex}
{%
  \if*#2*\else\NAT@cmt#2\fi
  \if\relax\NAT@date\relax\else\NAT@@close\fi
}
{%
  \if\relax\NAT@date\relax\else\NAT@@close\fi
  \if*#2*\else\textsuperscript{#2}\fi
}{}{}

\renewcommand\NAT@cite[3]{%
    \ifNAT@swa
        \NAT@@open
        \if*#2*\else#2\NAT@spacechar\fi
        #1\NAT@@close
        \if*#3*\else\textsuperscript{#3}\fi
    \else
        #1%
    \fi
    \endgroup
}

% 参考文献：五号字体、行距 13pt、零段间距、悬挂缩进 2 个中文字符
\renewcommand\bibfont{\normalfont\fontsize{10.5pt}{13pt}\selectfont}
\setlength{\bibsep}{0bp}
\setlength{\bibhang}{2\ccwd}
\renewcommand\@biblabel[1]{[#1]\hfill}                % [n] 编号、右对齐
\urlstyle{same}
% 允许 URL 在任意字母 / 数字后断行
\g@addto@macro\UrlBreaks{%
  \do\a\do\b\do\c\do\d\do\e\do\f\do\g\do\h\do\i\do\j%
  \do\k\do\l\do\m\do\n\do\o\do\p\do\q\do\r\do\s\do\t%
  \do\u\do\v\do\w\do\x\do\y\do\z%
  \do\A\do\B\do\C\do\D\do\E\do\F\do\G\do\H\do\I\do\J%
  \do\K\do\L\do\M\do\N\do\O\do\P\do\Q\do\R\do\S\do\T%
  \do\U\do\V\do\W\do\X\do\Y\do\Z%
  \do\1\do\2\do\3\do\4\do\5\do\6\do\7\do\8\do\9\do\0%
}
% 参考文献章级标题：临时退出 mainmatter 以避免影响页码与章号
\renewcommand\bibsection{%
    \@mainmatterfalse
    \chapter{\bibname}%
    \@mainmattertrue
}

% ============================================================================
% 第12部分: 数学环境
% ============================================================================
\RequirePackage{amsmath,amsthm}
% 注：数学公式的 \abovedisplayskip 等已在 \renewcommand\normalsize（第 10 部分）
% 中按字号分别设置，此处不再统一覆盖。

% 定理风格 hnuplain：标题黑体，定理体首行缩进 2 字，标题与正文间空 1 字
\newtheoremstyle{hnuplain}%
    {}{}%
    {}{2\ccwd}%
    {\bfseries}{}%
    {\ccwd}{}
\theoremstyle{hnuplain}

% 定理类中文名
\newcommand\hnu@assertionname{断言}
\newcommand\hnu@axiomname{公理}
\newcommand\hnu@corollaryname{推论}
\newcommand\hnu@definitionname{定义}
\newcommand\hnu@examplename{例}
\newcommand\hnu@lemmaname{引理}
\newcommand\hnu@proofname{证明}
\newcommand\hnu@propositionname{命题}
\newcommand\hnu@remarkname{注}
\newcommand\hnu@theoremname{定理}

% 与 theorem 共用编号、按章重置
\newtheorem{theorem}                {\hnu@theoremname}     [chapter]
\newtheorem{assertion}  [theorem]   {\hnu@assertionname}
\newtheorem{axiom}      [theorem]   {\hnu@axiomname}
\newtheorem{corollary}  [theorem]   {\hnu@corollaryname}
\newtheorem{lemma}      [theorem]   {\hnu@lemmaname}
\newtheorem{proposition}[theorem]   {\hnu@propositionname}
% 独立编号
\newtheorem{definition}             {\hnu@definitionname}  [chapter]
\newtheorem{example}                {\hnu@examplename}     [chapter]
% 不编号
\newtheorem*{remark}                {\hnu@remarkname}

% 重写 amsthm 的 proof，使首行缩进 2 字、标题加粗
\renewenvironment{proof}[1][\proofname]{
    \par
    \pushQED{\qed}%
    \normalfont
    \topsep6\p@\@plus6\p@\relax
    \trivlist
        \item\relax
        \hskip2\ccwd
        \textbf{#1}
        \hskip\ccwd\ignorespaces
    }{%
    \popQED
    \endtrivlist
    \@endpefalse
}
\renewcommand\proofname\hnu@proofname

% ============================================================================
% 第13部分: 算法与代码
% ============================================================================
% 算法：带框、按章编号、显示行号
\RequirePackage[algoruled, algochapter, lined, linesnumbered]{algorithm2e}
\renewcommand{\algorithmcfname}{算法}

% 代码清单
\RequirePackage{listings}
\lstset{
    basicstyle=\small\ttfamily,
    xleftmargin=2pc,
    xrightmargin=2pc,
    frame=single,
    columns=flexible,
    numbers=left,
}

% \rememberlines / \resumenumbering：跨 algorithm 块继续行号
\newcommand{\rememberlines}{\xdef\rememberedlines{\number\value{AlgoLine}}}
\newcommand{\resumenumbering}{\setcounter{AlgoLine}{\rememberedlines}}

% talgorithm：可向左右扩宽的浮动算法盒，便于宽算法溢出版心
\RequirePackage[skins]{tcolorbox}
\newtcolorbox{talgorithm}[2][]{%
  blanker,
  float=tbp,
  grow to left by=#2,
  grow to right by=#2,
  before upper={\begin{algorithm}[H]},
  after upper={\end{algorithm}},
  #1
}
