import decimal

from django.conf import settings


def D(val):
    if val is None:
        return decimal.Decimal(0)
    return decimal.Decimal(val)


def money_quant(amount):
    return amount.quantize(decimal.Decimal('.01'), decimal.ROUND_HALF_UP)


def USD(amount):
    return "${}".format(money_quant(amount))


def calc_cc_fee_amount(amount):
    return money_quant(amount * D(settings.CC_TRANSACTION_FEE_PERCENTAGE))

def multiple_buyer_number_parser(s):
    # convert a comma or space seperated string list of numbers into a list of numbers
    space_deliminated = s.split(' ')
    delim = []
    for i in space_deliminated:
        delim.extend([x.strip() for x in i.split(',')])

    return [x for x in delim if x is not None and x != '']