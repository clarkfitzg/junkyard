import Base.isless

# A type system for poker hands
# I'm incrementally building up the classes and methods I need


# Card Values
# ============================================================

# It's probably easier to map these symbols internally to integers to make comparison with < easier
struct CardValue
    value::Integer
end

function CardValue(value::AbstractString)
    vals = "2 3 4 5 6 7 8 9 10 J Q K A"
    val_order = split(vals)
    idx = findfirst(x -> x == value, val_order)
    CardValue(idx)
end

# Should see two methods now
methods(CardValue)

# Try out this newly defined constructor
jack = CardValue("J")
three = CardValue("3")

function isless(x::CardValue, y::CardValue)
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

function Card(x)

jh = Card(


abstract type Hand end

struct Pair <: Hand
    card::Card
end


