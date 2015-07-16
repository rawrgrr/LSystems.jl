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

### Drawing a Plant

![Plant Example Image](https://raw.githubusercontent.com/rawrgrr/LSystems.jl/master/examples/plant_9.png)

```julia
cr = CairoContext(c);

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

stroke(cr);
```

For the full example, see [`examples/draw_plant.jl`](https://github.com/rawrgrr/LSystems.jl/blob/master/examples/draw_plant.jl).

### Drawing a Dragon Curve

![Hilbert Curve Example Image](https://raw.githubusercontent.com/rawrgrr/LSystems.jl/master/examples/dragon_10.png)

```julia
cr = CairoContext(c);

dragon_start = "A"
dragon_trans = Dict([('A', "A+BF"), ('B', "FA-B")])

for v in @task lindenmayer(dragon_start, dragon_trans, 10)
    if v == 'F'
        x, y = determine_new_position(x, y, a, d)
        line_to(cr, x, y)
    elseif v == '+'
        a -= 90
    elseif v == '-'
        a += 90
    end
end

stroke(cr);
```

For the full example, see [`examples/draw_dragon.jl`](https://github.com/rawrgrr/LSystems.jl/blob/master/examples/draw_dragon.jl)

### Drawing a Koch Island

![Koch Island Example Image](https://raw.githubusercontent.com/rawrgrr/LSystems.jl/master/examples/koch_4.png)

```julia
cr = CairoContext(c);

koch_start = "F+F+F+F"
koch_trans = Dict([('F', "F+F-F-FF+F+F-F")])

for v in @task lindenmayer(koch_start, koch_trans, 4)
    if v == 'F'
        x, y = determine_new_position(x, y, a, d)
        line_to(cr, x, y)
    elseif v == '+'
        a -= 90
    elseif v == '-'
        a += 90
    end
end

stroke(cr);
```

For the full example, see [`examples/draw_koch.jl`](https://github.com/rawrgrr/LSystems.jl/blob/master/examples/draw_koch.jl)

### Drawing a Kristall Curve

![Kristall Curve Example Image](https://raw.githubusercontent.com/rawrgrr/LSystems.jl/master/examples/kristall_5.png)

```julia
cr = CairoContext(c);

kristall_start = "F"
kristall_trans = Dict([('F', "F+F--f+F-F++f-F"), ('f', "fff")])

for v in @task lindenmayer(kristall_start, kristall_trans, 5)
    if v == 'F' || v == 'f'
        x, y = determine_new_position(x, y, a, d)
        line_to(cr, x, y)
    elseif v == '+'
        a -= 90
    elseif v == '-'
        a += 90
    end
end

stroke(cr);
```

For the full example, see [`examples/draw_koch.jl`](https://github.com/rawrgrr/LSystems.jl/blob/master/examples/draw_kristall.jl)


### Drawing a Sierpinski Curve

![Sierpinski Curve Example Image](https://raw.githubusercontent.com/rawrgrr/LSystems.jl/master/examples/sierpinski_4.png)

```julia
cr = CairoContext(c);

sierpinski_start = "F+XF+F+XF"
sierpinski_trans = Dict([('X', "XF-F+F-XF+F+XF-F+F-X")])

for v in @task lindenmayer(sierpinski_start, sierpinski_trans, 4)
    if v == 'F'
        x, y = determine_new_position(x, y, a, d)
        line_to(cr, x, y)
    elseif v == '+'
        a -= 90
    elseif v == '-'
        a += 90
    end
end

stroke(cr);
```

For the full example, see [`examples/draw_sierpinski.jl`](https://github.com/rawrgrr/LSystems.jl/blob/master/examples/draw_sierpinski.jl)

### Drawing a Hilbert Curve

![Hilbert Curve Example Image](https://raw.githubusercontent.com/rawrgrr/LSystems.jl/master/examples/hilbert_6.png)

```julia
cr = CairoContext(c);

hilbert_start = "A"
hilbert_trans = Dict([('A', "-BF+AFA+FB-"), ('B', "+AF-BFB-FA+")])

for v in @task lindenmayer(hilbert_start, hilbert_trans, 6)
    if v == 'F'
        x, y = determine_new_position(x, y, a, d)
        line_to(cr, x, y)
    elseif v == '+'
        a -= pi / 2
    elseif v == '-'
        a += pi / 2
    end
end

stroke(cr);
```

For the full example, see [`examples/draw_hilbert.jl`](https://github.com/rawrgrr/LSystems.jl/blob/master/examples/draw_hilbert.jl).


## TODO

- [x] Initial implementation of a DOL-System
- [x] Setup graphical examples
- [ ] Add signature to take a function instead of a dictionary to determine the transition state (make dictionary version a call-through)
- [ ] Tokenizer to allow for words instead of characters
