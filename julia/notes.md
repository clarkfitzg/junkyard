---
layout: post
title: notes as I start to learn Julia
date: 2020-06-04 10:20
comments: false
categories: julia
---

_This seems to be morphing into a story about moving to Julia from R.
Perhaps I should move it somewhere else._

I've been curious about the Julia programming language for many years, and have decided to sit down and actually start learning it.
These are my notes as I read the [official documentation](https://docs.julialang.org/en/v1/).


## Things to be aware of

- [Arithmetic overflows wrap around](https://docs.julialang.org/en/v1/manual/integers-and-floating-point-numbers/#Overflow-behavior-1), like in C.
- What is a `do` block?
    The example in setting numeric precision appears to be making a temporary change in how a computation happens.


# What I Like

[Numeric literals for multiplication](https://docs.julialang.org/en/v1/manual/integers-and-floating-point-numbers/#man-numeric-literal-coefficients-1) is nice syntax: `2x` rather than `2*x`.

---

[LaTeX symbol keyboard shortcuts](https://docs.julialang.org/en/v1/manual/unicode-input/) at the REPL are convenient.
From the REPL, hit `?` to go into help mode, and then you can directly paste the Unicode character:
```
help?> ÷
"÷" can be typed by \div<tab>
```
The very first line of the documentation tells how to type it on the REPL.
This ease of use makes me think I could actually start using Unicode symbols in my code.


### Easy access to low level details

`bitstring` provides easy access to the binary representation of numbers.
For example, here's the binary representation of π:

```
julia> bitstring(Float64(π))
"0100000000001001001000011111101101010100010001000010110100011000"
```

This convenient access to binary representation would make it easy to teach material on numerical representations and [bitwise operations](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Bitwise-Operators-1).


### Loop fusion

The [vectorized dot operator](https://docs.julialang.org/en/v1/manual/mathematical-operations/#man-dot-operators-1) does loop fusion.
Thus, loop fusion is directly built into the language.

```
julia> a = [1, 2, 3]
3-element Array{Int64,1}:
 1
 2
 3
```

Here's how you square and add 1 to each element of an array.
```
julia> a.^2 .+ 1
3-element Array{Int64,1}:
  2
  5
 10
```

Alternative syntax for the same operation as above:
```
julia> @. a^2 + 1
3-element Array{Int64,1}:
  2
  5
 10
```



## Limitations

Here's what I immediately noticed was missing.

- No [support for vi mode from the REPL](https://discourse.julialang.org/t/vim-mode-in-repl-command-line/9023), so quick experiments with expressions take longer and are more tedious than necessary.
- Cannot [access the source code from the REPL](https://github.com/JuliaLang/julia/issues/2625#issuecomment-498840808), so when I'm experimenting with minor variations of a function I have to take the extra step of saving them in a text file.


## `zero` function

_I tried to reproduce this, but it didn't work.
All three expressions were constant folded and super fast, which is good.
I don't know why it behaved differently at first._

Here are three ways to make a 64 bit floating point 0 in Julia: `zero(Float64)`, `0.0`, `Float64(0)`.
Naively, I would expect that the compiler would treat these expressions inside a function body exactly the same, but it doesn't.

```
function f1(x)
    x == zero(Float64)
    end

function f2(x)
    x == 0.0
    end

function f3(x)
    x == Float64(0)
    end
```

When I benchmark, for example, with `@benchmark f1(0.0)`, I find `f1(0.0)` is fast at 0.03 ns, while `f2(0.0)` and `f3(0.0)` both take around 18ns.
This means that the compiler treats `zero(Float64)` differently.
