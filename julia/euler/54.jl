if false
    using Revise: includet
    includet("54.jl")
end

import Base.isless


# A type system for poker hands
# Incrementally build up the classes and methods necessary to compare hands


# Card Values
# ============================================================

# It's probably easier to map these symbols internally to integers to make comparison with < easier
struct CardValue
    value::Integer
end


# Strings are conceptually different from CardValues.
# According to the docs, I should use a Constructor rather than defining a convert method.
function CardValue(value::AbstractString)
    vals = "2 3 4 5 6 7 8 9 T J Q K A"
    val_order = split(vals)
    idx = findfirst(z -> z == value, val_order)
    #@assert !isnothing(idx)
    CardValue(idx)
end


function CardValue(value::AbstractChar)
    vs = string(value)
    CardValue(vs)
end

# Surprising that this is Any.
# I expected AbstractChar and AbstractString to share a common supertype
supertype(AbstractChar)


## Should see some methods now
methods(CardValue)

# Try out the newly defined constructors
jack = CardValue("J")
three = CardValue('3')


function Base.isless(x::CardValue, y::CardValue)
    x.value < y.value
end

# Works
@assert three < jack


# Cards
# ============================================================

struct Card
    value::CardValue
    suit::Char
end 


# Is this necessary?
#function convert(CardValue, x)
#    CardValue(x)
#end


jackohearts = Card('J', 'H')


function Card(x)
end


# Hands
# ============================================================

abstract type Hand end

struct Pair <: Hand
    card::Card
end
