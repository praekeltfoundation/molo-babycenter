from django import template
from molo.core.models import SectionPage

register = template.Library()


@register.inclusion_tag(
    'core/tags/nav_bar.html',
    takes_context=True
)
def nav_bar(context):
    language_page = context.get('language_page')
    if language_page:
        sections = language_page.sections()
    else:
        sections = SectionPage.objects.none()
    return {
        'sections': sections,
        'request': context['request'],
    }
