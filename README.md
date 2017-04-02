# Identicon Generator

An Identicon generator built in [`Elixir`](http://elixir-lang.org/) that takes your name and produces an image similar to the default github profile images - (based on the Udemy course [`The Complete Elixir and Phoenix Bootcamp`](https://www.udemy.com/the-complete-elixir-and-phoenix-bootcamp-and-tutorial/))

to get started:

+ make sure you have [`Elixir` installed](http://elixir-lang.org/install.html)
+ clone the repo and run

```
> iex -S mix
```

+ to make your own image run:

```elixir
# put your name as a string where your_name is
iex> Identicon.main(your_name)
```
+ this will make a new identicon for you

here's the beautiful one it make for "smellyandrew"

![smellyandrew](/smellyandrew.png)
