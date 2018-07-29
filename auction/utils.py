import decimal


def D(val):
    if val is None:
        return decimal.Decimal(0)
    return decimal.Decimal(val)


def USD(d):
    quant = d.quantize(decimal.Decimal('.01'), decimal.ROUND_HALF_UP)
    return "${}".format(quant)