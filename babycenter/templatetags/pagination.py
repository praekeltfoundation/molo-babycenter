from django import template

register = template.Library()


@register.simple_tag()
def get_pages(page, padding=2, edge_padding=2):
    pages = list(page.paginator.page_range)
    curr = page.number - 1

    start = []
    end = []
    if (page.number > edge_padding):
        start = pages[:edge_padding]
    if (page.number <= len(pages) - edge_padding):
        end = pages[-edge_padding:]
    before_current = list(set(pages[curr - padding:curr]) - set(start))
    after_current = list(set(
        pages[page.number:page.number + padding]) - set(end))

    ellipses_before = curr > edge_padding + padding
    ellipses_after = page.number < len(pages) - (edge_padding + padding)

    return {
        'start': start,
        'end': end,
        'before_current': before_current,
        'after_current': after_current,
        'ellipses_before': ellipses_before,
        'ellipses_after': ellipses_after
    }
