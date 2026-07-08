from pathlib import Path

from reportlab.lib import colors
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.lib.units import mm
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.platypus import Paragraph, SimpleDocTemplate, Spacer, Table, TableStyle


ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "output" / "pdf"
OUT.mkdir(parents=True, exist_ok=True)
PDF_PATH = OUT / "MoonDeadlineKit_项目申报书.pdf"

FONT = "Helvetica"
for candidate in [Path("C:/Windows/Fonts/msyh.ttc"), Path("C:/Windows/Fonts/simhei.ttf"), Path("C:/Windows/Fonts/simsun.ttc")]:
    if candidate.exists():
        pdfmetrics.registerFont(TTFont("CNFont", str(candidate)))
        FONT = "CNFont"
        break

styles = getSampleStyleSheet()
title = ParagraphStyle("TitleCN", parent=styles["Title"], fontName=FONT, fontSize=19, leading=25, textColor=colors.HexColor("#17395f"), alignment=1, spaceAfter=16)
section = ParagraphStyle("SectionCN", parent=styles["Heading2"], fontName=FONT, fontSize=12, leading=16, textColor=colors.HexColor("#17395f"), spaceBefore=7, spaceAfter=5)
body = ParagraphStyle("BodyCN", parent=styles["BodyText"], fontName=FONT, fontSize=9.5, leading=14, spaceAfter=5)
cell = ParagraphStyle("CellCN", parent=body, leading=13, spaceAfter=0)


def p(text, style=body):
    return Paragraph(text, style)


story = [p("MoonDeadlineKit 项目申报书", title)]
rows = [
    ("项目名称", "MoonDeadlineKit：面向 MoonBit 的超时预算、截止时间与任务期限传播基础库"),
    ("参赛者", "范钰暄"),
    ("联系方式", "15797813628"),
    ("GitHub 仓库", "https://github.com/Fyx-9998/MoonDeadlineKit"),
    ("GitLink 仓库", "https://www.gitlink.org.cn/Fyx6668/MoonDeadlineKit"),
    ("项目方向", "MoonBit 工程可靠性 / Deadline / Timeout Budget 基础设施"),
    ("是否移植", "否，原创 MoonBit 基础库项目"),
]
table = Table([[p(k, cell), p(v, cell)] for k, v in rows], colWidths=[34 * mm, 146 * mm])
table.setStyle(TableStyle([
    ("FONTNAME", (0, 0), (-1, -1), FONT),
    ("BACKGROUND", (0, 0), (0, -1), colors.HexColor("#eaf2fb")),
    ("TEXTCOLOR", (0, 0), (0, -1), colors.HexColor("#17395f")),
    ("GRID", (0, 0), (-1, -1), 0.35, colors.HexColor("#b7c8d8")),
    ("VALIGN", (0, 0), (-1, -1), "MIDDLE"),
    ("LEFTPADDING", (0, 0), (-1, -1), 7),
    ("RIGHTPADDING", (0, 0), (-1, -1), 7),
    ("TOPPADDING", (0, 0), (-1, -1), 5),
    ("BOTTOMPADDING", (0, 0), (-1, -1), 5),
]))
story += [table, Spacer(1, 8)]

sections = [
    ("一、项目简介", "MoonDeadlineKit 面向 MoonBit 生态提供超时预算、截止时间和任务期限传播能力。项目不调用系统时钟，而是使用整数毫秒和外部传入时间点做纯计算，便于在 Wasm、JavaScript 和 native 后端保持一致行为。"),
    ("二、核心功能", "项目已实现 Deadline、BudgetSlice、SplitPlan、DeadlineReport、DeadlineDecision 与 JSON 导出，支持剩余时间计算、过期判断、子任务预算分配、预算拆分、任务启动前预算守卫和 CLI 演示。"),
    ("三、创新点和价值", "真实工程中一次请求往往会拆成多个下游调用，单个 timeout 很容易失控。MoonDeadlineKit 把链路剩余时间、子任务授权时间和拒绝原因变成可测试 API，可用于 RPC、队列任务、爬虫、批处理和 CI 质量门禁。"),
    ("四、与社区项目差异", "项目不做重试熔断、限流、SLO 统计、调度执行器或系统定时器。它专注任务执行前的时间预算计算，与前述项目可组合但不重叠。"),
    ("五、当前完成情况", "仓库包含 MoonBit 源码、9 个回归测试、CLI 示例、README、RELATED_WORK、ACCEPTANCE、CHANGELOG、GitHub Actions CI、接口元数据和本申报书。当前可运行 moon check --target all、moon test --target wasm、moon test --target wasm-gc、moon test --target js 与 moon run cmd/main。"),
    ("六、技术路线", "第一阶段提供确定性 deadline 和预算模型；第二阶段扩展 deadline 继承、链路 trace 标识和更丰富的 split 策略；第三阶段补充 HTTP/RPC/队列任务等真实接入示例。"),
    ("七、验收与质量保障", "CI 使用官方安装流程，并执行 check、test、fmt diff、moon info diff 和 CLI 演示。测试覆盖超时边界、子预算分配、拆分余数、报告状态、守卫决策和 JSON 输出。"),
    ("八、后续计划", "继续补充 trace deadline header 编解码、更多分配策略、benchmark、错误案例文档和可视化 deadline 传播示例。"),
    ("九、提交说明", "项目围绕公开仓库分步骤提交，每个提交对应一个可解释功能或材料节点，便于评审追踪开发过程。"),
]
for heading, text in sections:
    story += [p(heading, section), p(text)]

doc = SimpleDocTemplate(str(PDF_PATH), pagesize=A4, leftMargin=18 * mm, rightMargin=18 * mm, topMargin=18 * mm, bottomMargin=18 * mm)
doc.build(story)
print(PDF_PATH)
