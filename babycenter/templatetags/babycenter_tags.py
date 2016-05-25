from django.template import Library

register = Library()


@register.assignment_tag(takes_context=True)
def load_sections(context):
    request = context['request']
    locale_code = context.get('locale_code')

    if request.site:
        qs = request.site.root_page.specific.sections()
    else:
        qs = []

    return [a.get_translation_for(locale_code) or a for a in qs]
