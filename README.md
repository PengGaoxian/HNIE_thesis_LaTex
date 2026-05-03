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

3. 编译：

   ```bash
   xelatex main.tex
   xelatex main.tex   # 运行两次以生成正确的目录和交叉引用
   ```

---

## 关键文件说明

| 文件/目录 | 说明 |
|---|---|
| `main.tex` | 主文件，编译入口，填写封面信息、引入各章节 |
| `hnuthesis.cls` | 文档类文件，包含所有格式定义，一般无需修改 |
| `references.bib` | 参考文献数据库（BibTeX 格式） |
| `chapters/` | 论文章节目录，分章编写便于管理 |
| `chapters/abstract.tex` | 中英文摘要 |
| `chapters/ch1.tex` | 第一章正文（可按需增减） |
| `chapters/summary.tex` | 总结与展望 |
| `chapters/acknowledgements.tex` | 致谢 |
| `chapters/publications.tex` | 攻读学位期间发表的论文（附录） |
| `chapters/projects.tex` | 参与的科研项目（附录） |
| `figures/` | 插图目录，支持 EPS、PDF、PNG、JPG 等格式 |
| `main.pdf` | 编译生成的论文 PDF |

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

## 参考资源

- 关于 LaTeX 入门，参阅 [thuthesis](https://github.com/tuna/thuthesis)、[ustcthesis](https://github.com/ustctug/ustcthesis) 等项目的文档
- 本项目文档类基于 [hnuthesis](https://github.com/hnuthesis/hnuthesis) 修改
