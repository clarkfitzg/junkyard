import Base.convert

struct CardValue
    value::Integer
end


# This wreaks all kinds of havoc:
#function convert(CardValue, x::AbstractString)

function convert(::Type{CardValue}, x::AbstractString)
    vals = "2 3 4 5 6 7 8 9 T J Q K A"
    val_order = split(vals)
    idx = findfirst(z -> z == x, val_order)
    #@assert !isnothing(idx)
    CardValue(idx)
end


jack = CardValue("J")

