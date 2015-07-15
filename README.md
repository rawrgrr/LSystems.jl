# LSystems

[![Build Status](https://travis-ci.org/rawrgrr/LSystems.jl.svg?branch=master)](https://travis-ci.org/rawrgrr/LSystems.jl)
[![Coverage Status](https://coveralls.io/repos/rawrgrr/LSystems.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/rawrgrr/LSystems.jl?branch=master)

Lindenmayer Systems for [Julia](http://julialang.org/)


## Text Example

Algae-growth from [Wikipedia](https://en.wikipedia.org/wiki/L-system#Example_1:_Algae).

```julia
using LSystems

algae_start = "A"
algae_transition = Dict([('A', "AB"), ('B', "A")])

for c in @task lindenmayer(algae_start, algae_transition, 7)
    print(c)
end
```

Output would be `ABAABABAABAABABAABABAABAABABAABAAB`.


## Graphical Examples

![Plant Example Image](https://raw.githubusercontent.com/rawrgrr/LSystems.jl/master/examples/plant_9.png)

For some example boilerplate code of setting up graphical output, see [`examples/draw_plant.jl`](https://github.com/rawrgrr/LSystems.jl/blob/master/examples/draw_plant.jl).

A snippet of sample code that draws the plant seen above:

```julia
plant_start = "X"
plant_trans = Dict([('X', "F-[[X]+X]+F[+FX]-X"), ('F', "FF")])

for v in @task lindenmayer(plant_start, plant_trans, 9)
    if v == 'F'
        x, y = determine_new_position(x, y, a, d)
        line_to(cr, x, y)
    elseif v == '+'
        a -= pi / 7
    elseif v == '-'
        a += pi / 7
    elseif v == '['
        push!(s, [x, y, a])
    elseif v == ']'
        x, y, a = pop!(s)
        move_to(cr, x, y)
    end
end

stroke(cr)
```

![Hilbert Curve Example Image](https://raw.githubusercontent.com/rawrgrr/LSystems.jl/master/examples/hilbert_5.png)

## TODO

- [x] Initial implementation of a DOL-System
- [x] Setup graphical examples
- [ ] Add signature to take a function instead of a dictionary to determine the transition state (make dictionary version a call-through)
- [ ] Tokenizer to allow for words instead of characters
