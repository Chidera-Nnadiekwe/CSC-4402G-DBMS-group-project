import markdown
import os
import subprocess

md_path = "CSC4402_Group6_Report_Draft.md"
html_path = "CSC4402_Group6_Report_Draft.html"
pdf_path = "CSC4402_Group6_Report_Draft.pdf"

with open(md_path, "r", encoding="utf-8") as f:
    text = f.read()

# Configure TOC extension to only include h2 and h3
html = markdown.markdown(text, extensions=['tables', 'fenced_code', 'toc'], extension_configs={'toc': {'toc_depth': '2-3'}})

full_html = f"""
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
body {{ font-family: Arial, sans-serif; line-height: 1.6; margin: 40px; max-width: 800px; margin: 0 auto; padding: 40px; }}
table {{ border-collapse: collapse; width: 100%; margin-bottom: 20px; }}
th, td {{ border: 1px solid #ddd; padding: 8px; }}
th {{ background-color: #f2f2f2; }}
pre {{ background-color: #f4f4f4; padding: 10px; border-radius: 5px; overflow-x: auto; }}
code {{ font-family: Consolas, monospace; }}
h1, h2, h3 {{ color: #333; }}
a {{ color: #0066cc; text-decoration: none; }}
a:hover {{ text-decoration: underline; }}
.toc {{ background: #f9f9f9; padding: 20px; border-radius: 5px; }}
.toc ul {{ list-style-type: none; padding-left: 20px; }}
.toc > ul {{ padding-left: 0; }}
</style>
</head>
<body>
{html}
</body>
</html>
"""

with open(html_path, "w", encoding="utf-8") as f:
    f.write(full_html)

chrome_path = r"C:\Program Files\Google\Chrome\Application\chrome.exe"
abs_html = os.path.abspath(html_path)
abs_pdf = os.path.abspath(pdf_path)

# Run Chrome headless to generate PDF
cmd = [
    "powershell",
    "-Command",
    f"& '{chrome_path}' --headless --disable-gpu --print-to-pdf='{abs_pdf}' 'file:///{abs_html.replace(chr(92), '/')}'"
]

print(f"Running command: {' '.join(cmd)}")
subprocess.run(cmd)

if os.path.exists(abs_pdf):
    print("PDF generated successfully.")
else:
    print("PDF generation failed.")
