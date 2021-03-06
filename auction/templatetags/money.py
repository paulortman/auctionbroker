from django import template
from auction.utils import USD

register = template.Library()

@register.filter(name='money')
def money(value, currency='USD'):
    """Converts a Decimal value into a monetary display"""
    return USD(value)
