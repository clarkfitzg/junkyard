#!usr/bin/env python3

KFREEZE = 273.15


class Kelvin():

    def __init__(self, temp):
        try:
            self.temp = temp.to_kelvin()
        except AttributeError:
            self.temp = float(temp)

    def __repr__(self):
        return "{}({})".format(type(self).__name__, self.temp)

    def __add__(self, other):
        raise ValueError("It only makes sense to me to add differences.")

    def __sub__(self, other):
        a = self.to_kelvin().temp
        b = other.to_kelvin().temp
        return Kelvin(a - b)

    def to_celsius(self):
        return Celsius(self.temp - KFREEZE)

    def to_fahrenheit(self):
        return Fahrenheit(self.temp * 9 / 5 - 459.67)


class KelvinDiff(Kelvin):

    def __add__(self, other):
        if not isinstance(other, KelvinDiff):
            raise ValueError("It only makes sense to me to add differences.")
        return KelvinDiff(self.temp + other.diff)


class Celsius(Kelvin):

    def to_kelvin(self):
        return Kelvin(self.temp + KFREEZE)


class Fahrenheit(Kelvin):

    def to_kelvin(self):
        return Kelvin((self.temp + 459.67) * 5/9)


if __name__ == "__main__":

    # freezing
    freezing = [Fahrenheit(32), Celsius(0), Kelvin(KFREEZE)]

    # boiling
    boiling = [Fahrenheit(212), Celsius(100), Kelvin(KFREEZE + 100)]
