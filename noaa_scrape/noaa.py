from lxml import html

tree = html.parse("/Users/clark/Desktop/Marine Recreational Information Program Query Index.htm")

snodes = tree.xpath("//select")
