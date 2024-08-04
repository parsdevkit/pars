from markdown.extensions import Extension
from markdown.preprocessors import Preprocessor
import re

class CodeBlockHeaderExtension(Extension):
    def extendMarkdown(self, md):
        md.registerExtension(self)
        md.preprocessors.register(CodeBlockHeaderPreprocessor(md), 'codeblockheader', 25)

class CodeBlockHeaderPreprocessor(Preprocessor):
    RE = re.compile(r'^\{\.python\s*\.view="([^"]+)"\s*\.download="([^"]+)"\s*\}\n(```python\n.*?\n```)', re.DOTALL)

    def run(self, lines):
        text = "\n".join(lines)
        while True:
            m = self.RE.search(text)
            if not m:
                break
            view_link = m.group(1)
            download_link = m.group(2)
            code_block = m.group(3)
            header = (
                f'<div class="code-block-header">\n'
                f'    <span>{view_link}</span>\n'
                f'    <div class="links">\n'
                f'        <a href="{download_link}" download>⬇️ İndir</a>\n'
                f'        <a href="{view_link}" target="_blank">🔍 Görüntüle</a>\n'
                f'    </div>\n'
                f'</div>\n'
            )
            replacement = f"{header}\n{code_block}"
            text = text[:m.start()] + replacement + text[m.end():]
        return text.split("\n")

def makeExtension(**kwargs):
    return CodeBlockHeaderExtension(**kwargs)
