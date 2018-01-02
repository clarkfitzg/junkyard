#!usr/bin/env python3

class kelvin(float):

    def __add__(self, other):
        other = kelvin(other)
        return kelvin(super().__add__(self, other))

    def to_celsius(self):
        return celsius(self - 273.15)


class celsius(kelvin):

    def to_kelvin(self):
        return kelvin(self + 273.15)


class fahrenheit(celsius):

    def to_kelvin(self):
        return kelvin(self + 459.67) * 5/9





f = fahrenheit(32)
c = celsius(0)

k = kelvin(10)
