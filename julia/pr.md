For context, I'm a new user coming from R and Python.
While reading the string docs, I went down a short rabbit hole with `ans`:

> Where did this `ans` come from?
> There must have been some hidden assignment that happened somewhere, maybe in a hidden block in the docs that they forgot to show.
> (Looks up docs), ah, `ans` is a keyword.
> What are the semantics?
> Will it write over my variable `ans`?
> Yes, that's too bad, some people like to use ans as a variable name... (and so on)

I did read the [Getting Started](https://docs.julialang.org/en/v1/manual/getting-started/), but a couple days later when I returned to the docs I forgot about `ans`.
`ans` strikes me as a convenience, not a core feature of the language.
Why make something potentially confusing the first thing that a new user sees in the manual?

For the integers and floating point numbers, continually reassigning the variable `x` with objects of different types reinforces that Julia is dynamically typed, which is a core feature of the language.

It seems that the doctests are failing locally 
