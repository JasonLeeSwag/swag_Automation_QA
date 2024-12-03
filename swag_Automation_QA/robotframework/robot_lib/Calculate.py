from decimal import Decimal, ROUND_HALF_UP

class Calculate:
    def  rounding(self, value, decimalPlaces):
        value = float(value)
        if decimalPlaces == '2':
            value = Decimal(str(value)).quantize(Decimal('.00'), ROUND_HALF_UP)
            value = '%.2f'%value
        elif decimalPlaces == '3':
            value = Decimal(str(value)).quantize(Decimal('.000'), ROUND_HALF_UP)
        else:
            value = Decimal(str(value)).quantize(Decimal('.0000'), ROUND_HALF_UP)
            value = '%.4f'%value
        value = float(value)
        return (value)
