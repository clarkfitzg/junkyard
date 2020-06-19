if false
    using Revise: includet
    includet("54.jl")
end

#import Base.isless


# A type system for poker hands
# Incrementally build up the classes and methods necessary to compare hands


# Card Values
# ============================================================

# It's probably easier to map these symbols internally to integers to make comparison with < easier
struct CardValue{T<:Integer}
    value::T
end


# Strings are conceptually different from CardValues.
# According to the docs, I should use a Constructor rather than defining a convert method.
function CardValue(value::AbstractString)
    vals = "2 3 4 5 6 7 8 9 T J Q K A"
    val_order = split(vals)
    idx = findfirst(z -> z == value, val_order)
    @assert !isnothing(idx)
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


function Card(value, suit)
    v = CardValue(value)
    Card(v, suit)
end


jackohearts = Card('J', 'H')


function Card(x::AbstractString)
    @assert length(x) == 2
    Card(x[1], x[2])
end

queenspades = Card("QS")

# Because they share the same implementation I could do this:
# function Base.isless(x::Union{CardValue, Card}, y::Union{CardValue, Card})

function Base.isless(x::Card, y::Card)
    x.value < y.value
end

@assert jackohearts < queenspades


# Hands
# ============================================================

abstract type Hand end

# Sorted with the highest Cards first
SortedCards = Tuple{Card}

struct HighCard <: Hand
    cards::SortedCards
end


function HighCard(cards)
    HighCard(sort(cards))
end


struct Pair <: Hand
    pair::SortedCards
    other::SortedCards
end


function Pair(cards)
    vals = 
end


struct TwoPair <: Hand
    highpair::SortedCards
    lowpair::SortedCards
    other::SortedCards
end


struct Threeuva <: Hand
    three::SortedCards
    other::SortedCards
end


struct Straight <: Hand
    three::SortedCards
    other::SortedCards
end


struct Flush <: Hand
    cards::SortedCards
end


struct FullHouse <: Hand
    three::SortedCards
    pair::SortedCards
end


struct Fouruva <: Hand
    four::SortedCards
    other::SortedCards
end


struct StraightFlush <: Hand
    cards::SortedCards
end




"""
High Card: Highest value card.
One Pair: Two cards of the same value.
Two Pairs: Two different pairs.
Three of a Kind: Three cards of the same value.
Straight: All cards are consecutive values.
Flush: All cards of the same suit.
Full House: Three of a kind and a pair.
Four of a Kind: Four cards of the same value.
Straight Flush: All cards are consecutive values of same suit.
"""
function Hand(x::AbstractString)
    cards = split(x)
    cards = Card.(cards)
    for H in [StraightFlush, Fouruva, FullHouse, Flush, Straight, Threeuva, TwoPair, OnePair, HighCard]
        try 
            return H(cards)
        catch e
        end
    end
end


#pairfives = Hand("5H 5C 6S 7S KD")
