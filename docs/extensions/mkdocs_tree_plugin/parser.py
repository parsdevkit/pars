import re
import urllib.parse


class FileTreeParser:
    space = '    '
    branch = '│   '
    tee = '├── '
    last = '└── '

# https://pictogrammers.com/library/mdi/
    mime_icons = {
        'cs': '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><title>Code</title><path d="M13,9H18.5L13,3.5V9M6,2H14L20,8V20A2,2 0 0,1 18,22H6C4.89,22 4,21.1 4,20V4C4,2.89 4.89,2 6,2M6.12,15.5L9.86,19.24L11.28,17.83L8.95,15.5L11.28,13.17L9.86,11.76L6.12,15.5M17.28,15.5L13.54,11.76L12.12,13.17L14.45,15.5L12.12,17.83L13.54,19.24L17.28,15.5Z" /></svg>',
        'mp3': '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><title>Audio</title><path d="M14,2H6A2,2 0 0,0 4,4V20A2,2 0 0,0 6,22H18A2,2 0 0,0 20,20V8L14,2M13,13H11V18A2,2 0 0,1 9,20A2,2 0 0,1 7,18A2,2 0 0,1 9,16C9.4,16 9.7,16.1 10,16.3V11H13V13M13,9V3.5L18.5,9H13Z" /></svg>',
        "mp4": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><title>Video</title><path d="M14,2L20,8V20A2,2 0 0,1 18,22H6A2,2 0 0,1 4,20V4A2,2 0 0,1 6,2H14M18,20V9H13V4H6V20H18M16,18L13.5,16.3V18H8V13H13.5V14.7L16,13V18Z" /></svg>',
        'pdf': '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><title>PDF</title><path d="M19 3H5C3.9 3 3 3.9 3 5V19C3 20.1 3.9 21 5 21H19C20.1 21 21 20.1 21 19V5C21 3.9 20.1 3 19 3M9.5 11.5C9.5 12.3 8.8 13 8 13H7V15H5.5V9H8C8.8 9 9.5 9.7 9.5 10.5V11.5M14.5 13.5C14.5 14.3 13.8 15 13 15H10.5V9H13C13.8 9 14.5 9.7 14.5 10.5V13.5M18.5 10.5H17V11.5H18.5V13H17V15H15.5V9H18.5V10.5M12 10.5H13V13.5H12V10.5M7 10.5H8V11.5H7V10.5Z" /></svg>',
        'docx': '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><title>Word</title><path d="M14,2H6A2,2 0 0,0 4,4V20A2,2 0 0,0 6,22H18A2,2 0 0,0 20,20V8L14,2M15.2,20H13.8L12,13.2L10.2,20H8.8L6.6,11H8.1L9.5,17.8L11.3,11H12.6L14.4,17.8L15.8,11H17.3L15.2,20M13,9V3.5L18.5,9H13Z" /></svg>',
        'xlsx': '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><title>Excel</title><path d="M14,2H6A2,2 0 0,0 4,4V20A2,2 0 0,0 6,22H18A2,2 0 0,0 20,20V8L14,2M15.8,20H14L12,16.6L10,20H8.2L11.1,15.5L8.2,11H10L12,14.4L14,11H15.8L12.9,15.5L15.8,20M13,9V3.5L18.5,9H13Z" /></svg>',
        'gif': '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><title>GIF</title><path d="M19 3H5C3.9 3 3 3.9 3 5V19C3 20.1 3.9 21 5 21H19C20.1 21 21 20.1 21 19V5C21 3.9 20.1 3 19 3M10 10.5H7.5V13.5H8.5V12H10V13.7C10 14.4 9.5 15 8.7 15H7.3C6.5 15 6 14.3 6 13.7V10.4C6 9.7 6.5 9 7.3 9H8.6C9.5 9 10 9.7 10 10.3V10.5M13 15H11.5V9H13V15M17.5 10.5H16V11.5H17.5V13H16V15H14.5V9H17.5V10.5Z" /></svg>',
        'png': '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><title>PNG</title><path d="M19 3H5C3.9 3 3 3.9 3 5V19C3 20.1 3.9 21 5 21H19C20.1 21 21 20.1 21 19V5C21 3.9 20.1 3 19 3M9 11.5C9 12.3 8.3 13 7.5 13H6.5V15H5V9H7.5C8.3 9 9 9.7 9 10.5V11.5M14 15H12.5L11.5 12.5V15H10V9H11.5L12.5 11.5V9H14V15M19 10.5H16.5V13.5H17.5V12H19V13.7C19 14.4 18.5 15 17.7 15H16.4C15.6 15 15.1 14.3 15.1 13.7V10.4C15 9.7 15.5 9 16.3 9H17.6C18.4 9 18.9 9.7 18.9 10.3V10.5H19M6.5 10.5H7.5V11.5H6.5V10.5Z" /></svg>',
        'jpg': '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><title>JPG</title><path d="M19 3H5C3.9 3 3 3.9 3 5V19C3 20.1 3.9 21 5 21H19C20.1 21 21 20.1 21 19V5C21 3.9 20.1 3 19 3M9 13.5C9 14.6 8.1 15 7 15S5 14.6 5 13.5V12H6.5V13.5H7.5V9H9V13.5M14 11.5C14 12.3 13.3 13 12.5 13H11.5V15H10V9H12.5C13.3 9 14 9.7 14 10.5V11.5M19 10.5H16.5V13.5H17.5V12H19V13.7C19 14.4 18.5 15 17.7 15H16.4C15.6 15 15.1 14.3 15.1 13.7V10.4C15 9.7 15.5 9 16.3 9H17.6C18.4 9 18.9 9.7 18.9 10.3V10.5M11.5 10.5H12.5V11.5H11.5V10.5Z" /></svg>',
        'jpeg': '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><title>Image</title><path d="M13,9H18.5L13,3.5V9M6,2H14L20,8V20A2,2 0 0,1 18,22H6C4.89,22 4,21.1 4,20V4C4,2.89 4.89,2 6,2M6,20H15L18,20V12L14,16L12,14L6,20M8,9A2,2 0 0,0 6,11A2,2 0 0,0 8,13A2,2 0 0,0 10,11A2,2 0 0,0 8,9Z" /></svg>',
        'xml': '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><title>XML</title><path d="M19 3H5C3.89 3 3 3.89 3 5V19C3 20.11 3.89 21 5 21H19C20.11 21 21 20.11 21 19V5C21 3.89 20.11 3 19 3M8 15H6.5L6 13L5.5 15H4L4.75 12L4 9H5.5L6 11L6.5 9H8L7.25 12L8 15M15.5 15H14V10.5H13V14H11.5V10.5H10.5V15H9V11C9 9.9 9.9 9 11 9H13.5C14.61 9 15.5 9.9 15.5 11V15M20 15H17V9H18.5V13.5H20V15Z" /></svg>',
        'zip': '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><title>ZIP</title><path d="M20 6H12L10 4H4C2.9 4 2 4.9 2 6V18C2 19.1 2.9 20 4 20H20C21.1 20 22 19.1 22 18V8C22 6.9 21.1 6 20 6M18 12H16V14H18V16H16V18H14V16H16V14H14V12H16V10H14V8H16V10H18V12Z" /></svg>',
        # Add other mime types and their icons as needed
    }

    @staticmethod
    def combine_url(root_url, relative_path):
        return urllib.parse.urljoin(root_url, relative_path)

    @staticmethod
    def string_to_dict(annotation_str):
        annotations_dict = {}
        for part in annotation_str.split(','):
            key_value = part.split('=')
            key = key_value[0].strip()
            if len(key_value) > 1:
                value = key_value[1].strip()
                if (value.startswith('"') and value.endswith('"')) or (value.startswith("'") and value.endswith("'")):
                    value = value[1:-1]
            else:
                value = True
            annotations_dict[key] = value
        return annotations_dict

    @staticmethod
    def parse_annotations(item):
        name, *annotations = re.split(r'[\{\}]', item)
        annotations = [ann.strip() for ann in annotations if ann.strip()]
        annotations_dict = {}
        for annotation in annotations:
            annotations_dict.update(FileTreeParser.string_to_dict(annotation))
        return name.strip(), annotations_dict


    @staticmethod
    def determine_icons(annotations, filename, base_url):
        icons = []

        mime_type = annotations.get('mime')
        if not mime_type:
            if "." not in filename:
                mime_type = None
            else:
                ext = filename.split('.')[-1].lower()
                mime_type = ext
            
        # if mime_type == '':
        #     mime_type, encoding = mimetypes.guess_type(filename)
        
        for key, value in annotations.items():

            if key == 'indicator':
                if mime_type == None:
                    icons.append(FileTreeParser.mime_icons.get(mime_type, '<span class="twemoji"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><title>Folder</title><path d="M10,4H4C2.89,4 2,4.89 2,6V18A2,2 0 0,0 4,20H20A2,2 0 0,0 22,18V8C22,6.89 21.1,6 20,6H12L10,4Z" /></svg>'))
                else:
                    icons.append(FileTreeParser.mime_icons.get(mime_type, '<span class="twemoji"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><title>File</title><path d="M13,9H18.5L13,3.5V9M6,2H14L20,8V20A2,2 0 0,1 18,22H6C4.89,22 4,21.1 4,20V4C4,2.89 4.89,2 6,2M15,18V16H6V18H15M18,14V12H6V14H18Z" /></svg>'))

            if key == 'view':
                icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><title>View</title><path d="M12,9A3,3 0 0,1 15,12A3,3 0 0,1 12,15A3,3 0 0,1 9,12A3,3 0 0,1 12,9M12,4.5C17,4.5 21.27,7.61 23,12C21.27,16.39 17,19.5 12,19.5C7,19.5 2.73,16.39 1,12C2.73,7.61 7,4.5 12,4.5M3.18,12C4.83,15.36 8.24,17.5 12,17.5C15.76,17.5 19.17,15.36 20.82,12C19.17,8.64 15.76,6.5 12,6.5C8.24,6.5 4.83,8.64 3.18,12Z" /></svg>'
                path = annotations.get(key, filename)
                url = FileTreeParser.combine_url(base_url, path)
                link = f'<a href="{url}">{icon}</a>'
                icons.append(link)

            if key == 'open':
                icons.append('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><title>Open</title><path d="M14,3V5H17.59L7.76,14.83L9.17,16.24L19,6.41V10H21V3M19,19H5V5H12V3H5C3.89,3 3,3.9 3,5V19A2,2 0 0,0 5,21H19A2,2 0 0,0 21,19V12H19V19Z" /></svg>')

            if key == 'edit':
                icons.append('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><title>Edit</title><path d="M20.71,7.04C21.1,6.65 21.1,6 20.71,5.63L18.37,3.29C18,2.9 17.35,2.9 16.96,3.29L15.12,5.12L18.87,8.87M3,17.25V21H6.75L17.81,9.93L14.06,6.18L3,17.25Z" /></svg>')

            if key in ['download', 'download-7Z', 'download-zip', 'download-rar', 'download-targz']:
                title = "Download"
                if key == "download-7Z":
                    title = "Download 7Z"
                elif key == "download-zip":
                    title = "Download Zip"
                elif key == "download-rar":
                    title = "Download RAR"
                elif key == "download-targz":
                    title = "Download Tar GZ"
                    
                text = ""
                if key == "download-7Z":
                    text = ".7z"
                elif key == "download-zip":
                    text = ".zip"
                elif key == "download-rar":
                    text = ".rar"
                elif key == "download-targz":
                    text = ".tar.gz"
                    
                icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><title>{title}</title><path d="M5 3H19C20.11 3 21 3.9 21 5V19C21 20.11 20.11 21 19 21H5C3.9 21 3 20.11 3 19V5C3 3.9 3.9 3 5 3M8 17H16V15H8V17M16 10H13.5V7H10.5V10H8L12 14L16 10Z" /></svg>'
                path = annotations.get(key, filename)
                url = FileTreeParser.combine_url(base_url, path)
                link = f'<a href="{url}">{icon}{text}</a>'
                icons.append(link)
        

        wrapped_icons = []
        for icon in icons:
            wrapped_icons.append(f'<span class="twemoji">{icon}</span>')
            
        return wrapped_icons

    def parse_indented_tree(self, input_string):
        lines = input_string.strip().split('\n')
        rootLine, rootAnnotations = self.parse_annotations(lines[0].strip())
        

        extra_indent = 0
        if rootLine.strip() != ".":
            lines.insert(0, ".")
            extra_indent += 1

        file_tree = {}
        stack = [(file_tree, -1)]

        for line in lines[1:]:
            stripped_line = line.lstrip()
            indent_level = extra_indent + (len(line) - len(stripped_line)) // 4
            while stack and stack[-1][1] >= indent_level:
                stack.pop()
            current_level = stack[-1][0]
            
            name, annotations = self.parse_annotations(stripped_line)
            
            if name.endswith('/'):
                new_level = {}
                current_level[name] = {'children': new_level, 'annotations': annotations}
                stack.append((new_level, indent_level))
            else:
                current_level[name] = {'children': None, 'annotations': annotations}

        return file_tree

    def print_tree_html(self, header_annotations, current_level, prefix=''):
        base_url = header_annotations.get('base', ".")

        html = ''
        if prefix == '':
            html += "." + "\n"
        pointers = [self.tee] * (len(current_level) - 1) + [self.last]
        for pointer, (key, value) in zip(pointers, current_level.items()):
            annotations = value['annotations']
            icons = self.determine_icons(annotations, key, base_url)
            icons_str = ' '.join(icons)
            annotation_str = f" {{{', '.join(f'{k}={v}' if v is not True else k for k, v in annotations.items())}}}" if annotations else ''

            html += f'''<div class="code-block-header">
                <span>{prefix}{pointer}{key}</span>
                <div class="links">{icons_str}</div>
            </div>'''
            
            
            if isinstance(value['children'], dict):
                extension = self.branch if pointer == self.tee else self.space
                html += self.print_tree_html(header_annotations, value['children'], prefix + extension)
        return html

    def print_tree(self, current_level, prefix=''):
        base_url = header_annotations.get('base', ".")

        result = ''
        if prefix == '':
            result += "." + "\n"
        pointers = [self.tee] * (len(current_level) - 1) + [self.last]
        for pointer, (key, value) in zip(pointers, current_level.items()):
            annotations = value['annotations']
            icons = self.determine_icons(annotations, key, base_url)
            icons_str = ' '.join(icons)
            annotation_str = f" {{{', '.join(f'{k}={v}' if v is not True else k for k, v in annotations.items())}}}" if annotations else ''
            result += (prefix + pointer + key + ' ' + icons_str + "\n")
            if isinstance(value['children'], dict):
                extension = self.branch if pointer == self.tee else self.space
                result += self.print_tree(value['children'], prefix + extension)
            
        return result


    
    