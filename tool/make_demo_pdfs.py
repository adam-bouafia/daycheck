"""Builds the demo PDFs in assets/documents/. Fictional content only.

Run with any Python that has reportlab:
    python tool/make_demo_pdfs.py
"""

from pathlib import Path

from reportlab.lib import colors
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.lib.units import mm
from reportlab.platypus import (
    PageBreak,
    Paragraph,
    SimpleDocTemplate,
    Spacer,
    Table,
    TableStyle,
)

OUT = Path(__file__).resolve().parent.parent / "assets" / "documents"
MAUVE = colors.HexColor("#8839ef")
LIGHT = colors.HexColor("#efe6ff")
NAME = "Kinderopvang De Zonnebloem"

styles = getSampleStyleSheet()
h1 = ParagraphStyle("h1", parent=styles["Title"], textColor=MAUVE, alignment=0)
h2 = ParagraphStyle("h2", parent=styles["Heading2"], textColor=MAUVE)
body = ParagraphStyle("body", parent=styles["BodyText"], fontSize=10.5, leading=15)
small = ParagraphStyle("small", parent=body, fontSize=8.5, textColor=colors.grey)


def footer(canvas, doc):
    canvas.saveState()
    canvas.setFont("Helvetica", 8)
    canvas.setFillColor(colors.grey)
    canvas.drawString(20 * mm, 12 * mm, f"{NAME} - demo document, fictional data")
    canvas.drawRightString(190 * mm, 12 * mm, f"Page {doc.page}")
    canvas.restoreState()


def table(rows, widths, header=True):
    t = Table(rows, colWidths=widths)
    style = [
        ("GRID", (0, 0), (-1, -1), 0.4, colors.HexColor("#bcc0cc")),
        ("VALIGN", (0, 0), (-1, -1), "TOP"),
        ("FONTSIZE", (0, 0), (-1, -1), 9.5),
        ("TOPPADDING", (0, 0), (-1, -1), 5),
        ("BOTTOMPADDING", (0, 0), (-1, -1), 5),
    ]
    if header:
        style += [
            ("BACKGROUND", (0, 0), (-1, 0), LIGHT),
            ("FONTNAME", (0, 0), (-1, 0), "Helvetica-Bold"),
        ]
    t.setStyle(TableStyle(style))
    return t


def build(name, title, story):
    doc = SimpleDocTemplate(
        str(OUT / name),
        pagesize=A4,
        leftMargin=20 * mm,
        rightMargin=20 * mm,
        topMargin=20 * mm,
        bottomMargin=20 * mm,
        title=title,
        author=NAME,
    )
    doc.build(story, onFirstPage=footer, onLaterPages=footer)


def newsletter():
    s = [
        Paragraph(NAME, small),
        Paragraph("Newsletter - November 2026", h1),
        Paragraph(
            "Dear parents and carers, the leaves are falling and the groups "
            "have been busy collecting chestnuts, pine cones and the best "
            "puddles in the park. Here is what is coming up this month.",
            body,
        ),
        Paragraph("Dates", h2),
        table(
            [
                ["Date", "What", "Who"],
                ["Wed 11 Nov", "Lantern walk (Sint-Maarten), 17:30 at the main entrance", "All groups, parents welcome"],
                ["Fri 20 Nov", "Photographer visits, individual and group photos", "Butterflies, Ladybirds"],
                ["Mon 23 Nov", "Parent evening: sleep and routines (online)", "Parents"],
                ["Fri 4 Dec", "Sinterklaas party, morning only", "All groups"],
            ],
            [28 * mm, 92 * mm, 50 * mm],
        ),
        Paragraph("Theme of the month: autumn in the forest", h2),
        Paragraph(
            "We read <i>The Little Hedgehog</i>, make leaf prints and build a "
            "small hedgehog house in the garden. Please bring rain boots and a "
            "spare set of clothes labelled with your child's name.",
            body,
        ),
        Paragraph("Team news", h2),
        Paragraph(
            "We welcome Tim Visser to the Butterflies group from Monday 2 "
            "November. Sara Bakker is our new first-aid coordinator.",
            body,
        ),
        PageBreak(),
        Paragraph("Practical information", h2),
        table(
            [
                ["Opening hours", "Monday to Friday, 07:00 - 18:30"],
                ["Drop-off", "Before 09:30, so the morning circle can start"],
                ["Sick child", "Call before 08:00 or mark absent in the app"],
                ["Extra day", "Request it in the app at least two days ahead"],
                ["Phone", "020 123 4567 (demo number)"],
            ],
            [45 * mm, 125 * mm],
            header=False,
        ),
        Spacer(1, 8 * mm),
        Paragraph("Flu season", h2),
        Paragraph(
            "Please keep your child at home with a fever above 38.5 degrees and "
            "for 24 hours after it has gone. Tell us in the app, so both "
            "parents and the group know.",
            body,
        ),
        Spacer(1, 8 * mm),
        Paragraph("Warm regards, the team of De Zonnebloem", body),
    ]
    build("newsletter_november_2026.pdf", "Newsletter November 2026", s)


def menu():
    rows = [
        ["", "Breakfast", "Lunch", "Afternoon snack"],
        ["Monday", "Porridge with banana", "Wholemeal bread, cheese, cucumber", "Apple and rice cake"],
        ["Tuesday", "Yoghurt with muesli", "Vegetable soup, bread roll", "Pear and crackers"],
        ["Wednesday", "Wholemeal bread, jam", "Pasta with tomato sauce", "Carrot sticks, hummus"],
        ["Thursday", "Porridge with apple", "Bread, egg salad, tomato", "Mandarin and biscuit"],
        ["Friday", "Pancakes (small)", "Pumpkin soup, cheese toast", "Fruit salad"],
    ]
    s = [
        Paragraph(NAME, small),
        Paragraph("Weekly menu - week 47", h1),
        Paragraph("16 to 20 November 2026", body),
        Spacer(1, 5 * mm),
        table(rows, [24 * mm, 45 * mm, 55 * mm, 46 * mm]),
        Spacer(1, 6 * mm),
        Paragraph("Allergies and diets", h2),
        Paragraph(
            "Contains gluten: bread, pasta, crackers, pancakes. Contains milk: "
            "yoghurt, cheese, porridge. Children with an allergy get their own "
            "alternative; please keep the allergy list in the app up to date.",
            body,
        ),
        Paragraph("Drinks: water, milk and diluted fruit juice.", body),
    ]
    build("weekly_menu_week_47.pdf", "Weekly menu week 47", s)


def permission():
    line = "_" * 52
    s = [
        Paragraph(NAME, small),
        Paragraph("Permission form: visit to the petting zoo", h1),
        Paragraph(
            "On <b>Thursday 26 November 2026</b> the Ladybirds and Butterflies "
            "groups visit the petting zoo in the park, about 10 minutes on "
            "foot. We leave at 09:45 and are back for lunch at 12:00. Two "
            "staff members and two parent volunteers walk with every group.",
            body,
        ),
        Spacer(1, 6 * mm),
        table(
            [
                ["Child's name", line],
                ["Group", line],
                ["Parent or carer", line],
                ["Phone on the day", line],
                ["Allergies or notes", line],
            ],
            [45 * mm, 125 * mm],
            header=False,
        ),
        Spacer(1, 6 * mm),
        Paragraph("[  ]  My child may join the visit.", body),
        Paragraph("[  ]  My child may not join and stays at the daycare.", body),
        Paragraph("[  ]  I can walk along as a volunteer.", body),
        Paragraph("[  ]  Photos of my child taken on the trip may be shared in the app.", body),
        Spacer(1, 12 * mm),
        table(
            [["Date", "Signature"], ["\n\n", "\n\n"]],
            [60 * mm, 110 * mm],
        ),
        Spacer(1, 6 * mm),
        Paragraph("Please return before Friday 20 November. Thank you!", body),
    ]
    build("permission_petting_zoo.pdf", "Permission form petting zoo", s)


if __name__ == "__main__":
    OUT.mkdir(parents=True, exist_ok=True)
    newsletter()
    menu()
    permission()
    for p in sorted(OUT.glob("*.pdf")):
        print(p.name, p.stat().st_size)
