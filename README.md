# Morris 风格说理 · Codex Skill

把抽象观点落到具体变量和可解释的机制。从 @Morris_LT 的样本分析中提炼位置、资源、约束、激励与反馈框架，创作用户自己的冷静中文认知短文。

![Morris_LT 写作风格介绍](assets/style-overview.png)

> 上图由用户提供，展示报告样本中的历史数据与原帖。它是风格说明，不代表本项目获得原作者授权、合作或背书。

## 可以做什么

- 把成长、工作、商业问题写成清楚的一段式短文。
- 用关键区分与因果链改写泛泛的“认知金句”。
- 创作一句话判断、实用清单，或评审一段论证是否跳步。

默认短文 100–300 字，通常一段到底；金句约 15–50 字。用户指定的体裁和长度优先。

## 使用示例

```text
使用 $morris-lt-style，把“努力很久却没有积累”写成一篇约 200 字的原创认知短文。
```

```text
使用 $morris-lt-style，改写下面的草稿。保留原意，补足因果和适用条件，不增加虚构经历：
[粘贴草稿]
```

原创演示：

> 为什么忙了很久，仍然觉得自己停在原地？可以先看每次投入留下了什么。处理完一件事，只消除了当下的任务；把处理方法整理成可复用的流程，才可能降低下一次的成本。如果方向始终缺少外部反馈，熟练也可能只是更快地重复无效动作。每周检查留下的作品、得到验证的方法和需要修正的判断，积累才有具体的落点。

示例由本项目编写，不是 Morris 的原话。

## 安装到 Windows 的 F 盘

在 PowerShell 中执行：

```powershell
git clone https://github.com/badboywzw/morris-lt-style.git F:\codex\skills\morris-lt-style
powershell -NoProfile -ExecutionPolicy Bypass -File F:\codex\skills\morris-lt-style\install.ps1
```

实际文件默认保存在 `F:\codex\skills\morris-lt-style`，脚本在用户 Skill 发现目录创建目录联接：有 `CODEX_HOME` 时使用其 `skills` 子目录，否则使用 `~\.codex\skills`。脚本不会覆盖已有的不同目录。同一安装可重复执行。

其他位置可通过 `-SkillRoot` 和 `-DiscoveryRoot` 指定。其他系统可把整个仓库复制到自己的 Skill 发现目录，无需运行 Windows 脚本。在新会话中选择该 Skill，或使用上面的 `$morris-lt-style` 提示。

## 文件与来源

| 文件 | 用途 |
|---|---|
| [SKILL.md](SKILL.md) | 触发说明、分析框架、写作与事实边界 |
| [agents/openai.yaml](agents/openai.yaml) | 名称、简介与默认提示 |
| [写作手册](references/writing-playbook.md) | 体裁、推理检查与原创示例 |
| [原始蒸馏报告](references/source-report.md) | 用户提供的研究资料及原帖出处 |
| [install.ps1](install.ps1) | F 盘安装与目录联接 |

报告记录 183 条样本（2026-10-11 至 2026-10-24），部分长帖被截断，长度统计可能偏低；本项目没有重新抓取或独立核验报告中的数据。原始报告内的“人格提示词”作为文献保留，不直接执行。

本项目提炼表达与思考方法，不宣称原作者的著作、订阅业务或咨询经历属于使用者，不把生成文本冒充为原帖，也不自动发布内容。原帖、图片和作者标识的权利归各自权利人。
