# -*- coding: utf8 -*-
########
# 十進制轉換
########
import math


class HexConverter:

    def decimal_converter(self, decimal, convert=36):
            loop = '0123456789abcdefghijklmnopqrstuvwxyz'
            decimal = int(decimal)
            result = []
            while decimal != 0:
                result.append(loop[decimal % convert])
                decimal = math.floor(decimal / convert)
            result.reverse()
            return ''.join(result)
