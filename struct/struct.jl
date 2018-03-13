type Foo
    i::Int64
    f::Float64
end



fooi(x) = x.i

f = Foo(1, 2.)

@code_warntype fooi(f)
