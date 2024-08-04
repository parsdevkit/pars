from mkdocs.plugins import BasePlugin

class HelloWorldPlugin(BasePlugin):

    def on_page_content(self, html, page, config, files):
        # Sayfanın altına "Hello, World!" mesajı ekler
        return html + '<p>Hello, World!</p>'
