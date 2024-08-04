from textwrap import dedent
import urllib.parse
import re

x_intent = "https://twitter.com/intent/tweet"
fb_sharer = "https://www.facebook.com/sharer/sharer.php"


def on_page_markdown(markdown, **kwargs):
    page = kwargs['page']
    config = kwargs['config']

    page_url = config.site_url+page.url
    page_title = urllib.parse.quote(page.title+'\n')

    return markdown + dedent(f"""
    \n
    ---
    [:simple-x:]({x_intent}?text={page_title}&url={page_url}){{ .md-button .md-button-small }}
    [:simple-facebook:]({fb_sharer}?u={page_url}){{ .md-button .md-button-small }}
    """)