import os
import re
from mkdocs.plugins import BasePlugin
from mkdocs.structure.files import File
from .parser import FileTreeParser

class TreePlugin(BasePlugin):

    def on_page_markdown(self, markdown, page, config, files):
        tree_block_pattern = re.compile(r'```\s*{\s*\.tree(.*?)}(.*?)```', re.DOTALL)
        markdown = re.sub(tree_block_pattern, self.replace_tree_block, markdown)
        return markdown



    def on_config(self, config):
        config['extra_css'] = config.get('extra_css', [])
        config['extra_css'].append('assets/stylesheets/mkdocs_tree.css')
        return config


    def on_files(self, files, config):
        css_file = File(
            path="assets/stylesheets/mkdocs_tree.css",
            src_dir=os.path.dirname(__file__),
            dest_dir=config['site_dir'],
            use_directory_urls=config['use_directory_urls']
        )
        files.append(css_file)
        return files
    
        
    # def on_files(self, files, config):
    #     css_file = File(
    #         path="assets/stylesheets/mkdocs_tree.css",
    #         src_dir=os.path.join(os.path.dirname(__file__), 'assets/stylesheets'),
    #         dest_dir=config['site_dir'],
    #         use_directory_urls=config['use_directory_urls']
    #     )
    #     files.append(css_file)
    #     return files
    
    
    def replace_tree_block(self, match):
        header = match.group(1).strip()
        block = match.group(2).strip()
        # html_tree = self.convert_to_html(block)
        
        header_annotations = FileTreeParser.string_to_dict(header)
        
        parser = FileTreeParser()
        file_tree = parser.parse_indented_tree(block)

        html_tree = parser.print_tree_html(header_annotations, file_tree)
        
        header_title = '<span></span>'
        if 'title' in header_annotations:
            title = header_annotations.get('title', "title bululnamadı")
            header_title = f'<span class="filename">{title}</span>'
        
        html_tree = f'<div class="language-sh no-copy highlight"><pre>{header_title}<code class="md-code__content">{html_tree}</code></pre></div>'

        
        

        return html_tree

    def convert_to_html(self, tree_block):
        lines = tree_block.splitlines()
        tree_html = ['<ul class="file-tree">']

        indent_stack = [0]

        for line in lines:
            stripped_line = line.lstrip()
            indent_level = len(line) - len(stripped_line)
            content = stripped_line.strip()

            while indent_level < indent_stack[-1]:
                indent_stack.pop()
                tree_html.append('</ul>')
                tree_html.append('</li>')

            if indent_level > indent_stack[-1]:
                indent_stack.append(indent_level)
                tree_html.append('<ul>')

            if '{' in content:
                content, props = content.split('{', 1)
                content = content.strip()
                props = props.rstrip('}').strip()
                prop_dict = self.parse_properties(props)
                tree_html.append(self.render_item(content, prop_dict))
            else:
                tree_html.append(f'<li>{content}</li>')

        while len(indent_stack) > 1:
            indent_stack.pop()
            tree_html.append('</ul>')
            tree_html.append('</li>')

        tree_html.append('</ul>')
        return '\n'.join(tree_html)

    def parse_properties(self, prop_str):
        prop_dict = {}
        props = prop_str.split(',')
        for prop in props:
            if '=' in prop:
                key, value = prop.split('=', 1)
                prop_dict[key.strip()] = value.strip()
            else:
                prop_dict[prop.strip()] = True
        return prop_dict

    def render_item(self, content, props):
        item_html = f'<li>{content}<span class="icon-container">'
        if 'view' in props:
            item_html += f' <a href="{props["view"]}" target="_blank"><i class="fas fa-eye"></i></a>'
        if 'download' in props:
            item_html += f' <a href="{props["download"]}" download><i class="fas fa-download"></i></a>'
        if 'download-7Z' in props:
            item_html += ' <a href="#" download><i class="fas fa-file-archive"></i> 7Z</a>'
        if 'download-zip' in props:
            item_html += ' <a href="#" download><i class="fas fa-file-archive"></i> ZIP</a>'
        if 'download-rar' in props:
            item_html += ' <a href="#" download><i class="fas fa-file-archive"></i> RAR</a>'
        if 'download-targz' in props:
            item_html += ' <a href="#" download><i class="fas fa-file-archive"></i> TAR.GZ</a>'
        item_html += '</span></li>'
        return item_html



