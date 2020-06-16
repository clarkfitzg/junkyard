# A type system for poker hands

abstract type Hand end


# It's probably easier to map these symbols to integers to make comparison with < easier
# Possible values in order are: 2, 3, ..., 10, J, Q, K, A
struct CardValue
    value::Integer
end


struct Card
    suit::Char
    value::CardValue
end 


struct Pair
    card::Card
end


