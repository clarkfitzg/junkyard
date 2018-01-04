#!usr/bin/env python3

KFREEZE = 273.15


class kelvin():

    def __init__(self, temp):
        try:
            self.temp = temp.to_kelvin()
        except AttributeError:
            self.temp = float(temp)

    def __repr__(self):
        return "{}({})".format(type(self).__name__, self.temp)

    def __add__(self, other):
        raise NotImplementedError("Not sure what it means to 'add' temperatures.")

    def __sub__(self, other):
        a = self.to_kelvin().temp
        b = other.to_kelvin().temp
        return kelvin(a - b)

    def to_kelvin(self):
        return self

    def to_celsius(self):
        return celsius(self.temp - KFREEZE)

    def to_fahrenheit(self):
        return fahrenheit(self.temp * 9 / 5 - 459.67)



class celsius(kelvin):

    def to_kelvin(self):
        return kelvin(self.temp + KFREEZE)


class fahrenheit(kelvin):

    def to_kelvin(self):
        return kelvin((self.temp + 459.67) * 5/9)


if __name__ == "__main__":

    # freezing
    ff = fahrenheit(32)
    fc = celsius(0)
    fk = kelvin(KFREEZE)

    # boiling
    bf = fahrenheit(212)
    bc = celsius(100)
    bk = kelvin(KFREEZE)

    # These should be about the same
    (bf - fc).to_fahrenheit()

    (bc - ff).to_fahrenheit()

    (bk - fk).to_fahrenheit()
