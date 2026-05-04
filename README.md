# 湖南工程学院学士学位论文 LaTeX 模板

本项目是湖南工程学院学士学位论文 LaTeX 模板，基于 `hnuthesis.cls` 文档类编写，同时支持博士、硕士、学士三种论文类型。

> **注意**：个人能力、精力有限，不保证完全符合学校最新规范，_Use at your own risk!_

---

## 环境要求

- TeX 发行版：[TeX Live](https://www.tug.org/texlive/) 或 [MiKTeX](https://miktex.org/)（需包含 XeLaTeX）
- 编译引擎：**XeLaTeX**（必须，不支持 pdfLaTeX）
- 编辑器：推荐 [VS Code](https://code.visualstudio.com/) + LaTeX Workshop 插件，或 [Overleaf](https://cn.overleaf.com/)

---

## 快速开始

1. 在 `main.tex` 中选择论文类型：

   ```latex
   \documentclass[bachelor]{hnuthesis}  % doctor=博士, master=硕士, bachelor=学士
   ```

2. 填写封面信息（学校、题目、作者、导师等）：

   ```latex
   \hnuname{湖南工程学院}
   \title{论文题目}
   \author{作者姓名}
   \supervisor{导师姓名\ 职称}
   ```

3. 编译（推荐 `latexmk`，一条命令搞定）：

   ```bash
   latexmk -xelatex main.tex
   ```

   或手动执行完整序列（含参考文献处理）：

   ```bash
   xelatex main.tex
   bibtex main         # 处理 references.bib，新增 \cite 后必须重跑
   xelatex main.tex
   xelatex main.tex    # 第二次以解析目录和交叉引用
   ```

   > 仅运行 `xelatex main.tex` 两次会导致参考文献显示为 `[?]`，必须中间夹一次 `bibtex main`。

---

## 文档类选项

`\documentclass[...]{hnuthesis}` 支持以下选项，可组合使用：

| 类别 | 选项 | 说明 |
|---|---|---|
| 论文类型 | `doctor` | 博士学位论文（默认） |
| | `master` | 硕士学位论文 |
| | `bachelor` | 学士学位论文 |
| 引用格式 | `super` | 数字引用 + 上标显示（默认） |
| | `numbers` | 数字引用 + 行内显示 |
| | `authoryear` | 作者-年份引用格式 |
| 输出模式 | `print` | 双面打印模式（默认） |
| | `pdf` | 单面 PDF 模式（电子版） |

示例：

```latex
\documentclass[bachelor, numbers, pdf]{hnuthesis}
```

未识别的选项会自动透传给底层 `ctexbook` 类。

---

## 关键文件说明

| 文件/目录 | 说明 |
|---|---|
| `main.tex` | 主文件，编译入口，填写封面信息、引入各章节 |
| `hnuthesis.cls` | 文档类文件，包含所有格式定义，一般无需修改 |
| `hnunumerical.bst` | 数字引用模式下使用的 BibTeX 样式 |
| `references.bib` | 参考文献数据库（BibTeX 格式） |
| `chapters/` | 论文章节目录，分章编写便于管理 |
| `chapters/abstract.tex` | 中英文摘要 |
| `chapters/ch1.tex`、`ch2.tex` | 正文章节（可按需增减） |
| `chapters/summary.tex` | 总结与展望 |
| `chapters/acknowledgements.tex` | 致谢 |
| `chapters/publications.tex` | 攻读学位期间发表的论文（附录） |
| `chapters/projects.tex` | 参与的科研项目（附录） |
| `figures/` | 插图目录，支持 EPS、PDF、PNG、JPG 等格式 |
| `main.pdf` | 编译生成的论文 PDF |

新增章节时，需创建 `chapters/chN.tex` 并在 `main.tex` 的 `\mainmatter` 段中显式 `\input{chapters/chN}`，章节不会被自动发现。

---

## 论文类型切换

在 `main.tex` 第一行的 `\documentclass` 选项中切换：

```latex
\documentclass[doctor]{hnuthesis}   % 博士学位论文
\documentclass[master]{hnuthesis}   % 硕士学位论文
\documentclass[bachelor]{hnuthesis} % 学士学位论文（默认）
```

不同类型会自动切换封面样式、页眉内容、声明页等。

---

## 常见问题

**Q: 报错 `Package fontspec Error: The font "SimSun" cannot be found.`**

系统缺少中文字体（宋体/黑体/楷体/仿宋）。Windows 自带，macOS / Linux 上需要手动安装：可从 Windows 的 `C:\Windows\Fonts` 复制 `simsun.ttc`、`simhei.ttf`、`simkai.ttf`、`simfang.ttf` 到本地字体目录，或安装 [中易字体](https://github.com/StellarCN/scp_zh)。

**Q: 引用显示为 `[?]` 或 `(author?, year?)`**

未运行 `bibtex` 或参考文献处理顺序错误。按上文「快速开始」中的完整序列执行，或直接用 `latexmk -xelatex`。

**Q: 修改了 `references.bib` 但引用没更新**

删除 `main.aux`、`main.bbl` 后重新执行完整编译序列。`latexmk -C` 可一键清理所有中间产物。

**Q: 中文字符显示为方框或丢失**

确认编译引擎为 **XeLaTeX**，而不是 pdfLaTeX 或 LaTeX。文件首行的 `%!TEX program = xelatex` 可让多数编辑器自动选择正确引擎。

**Q: 目录、页眉显示不正确，或图表编号错乱**

只编译了一次。LaTeX 的目录与交叉引用需要至少两次 XeLaTeX 编译才能稳定。

---

## 参考资源

- 关于 LaTeX 入门，参阅 [thuthesis](https://github.com/tuna/thuthesis)、[ustcthesis](https://github.com/ustctug/ustcthesis) 等项目的文档
- 本项目文档类基于 [hnuthesis](https://github.com/hnuthesis/hnuthesis) 修改
