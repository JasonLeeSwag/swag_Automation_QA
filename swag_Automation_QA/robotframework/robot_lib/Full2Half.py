# -*- coding: utf8 -*-
########
# Convert To Half Shape
########


class Full2Half:

    def Full2Half(self, s):
            n = []
            for char in s:
                num = ord(char)
                if num == 0x3000:
                    num = 32
                elif 0xFF01 <= num <= 0xFF5E:
                    num -= 0xfee0

                num = chr(num)

                n.append(num)
            return ''.join(n)
