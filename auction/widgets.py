from django.forms import widgets


class MoneyWidget(widgets.TextInput):
    input_type = 'text'
    template_name = 'widgets/money.html'

