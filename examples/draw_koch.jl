using Cairo
using LSystems
using DataStructures

c = CairoRGBSurface(1024, 1024);
cr = CairoContext(c);

save(cr);

set_source_rgb(cr, 1.0, 1.0, 1.0);
rectangle(cr, 0.0, 0.0, 1024.0, 1024.0);
fill(cr);

restore(cr);
save(cr);

x, y, a, d = 260., 760., 0, 2.0
set_line_width(cr, 0.6);
move_to(cr, x, y);

koch_start = "F+F+F+F"
koch_trans = Dict([('F', "F+F-F-FF+F+F-F")])

function determine_new_position(x, y, a, d)
    x -= sind(a) * d
    y -= cosd(a) * d
    return x, y
end

s = Stack(Vector{Float64}) # [x, y, a]

level = 4
drawing_instructions = @task lindenmayer(koch_start, koch_trans, level)

for v in drawing_instructions
    if v == 'F'
        x, y = determine_new_position(x, y, a, d)
        line_to(cr, x, y)
    elseif v == '+'
        a -= 90
    elseif v == '-'
        a += 90
    elseif v == '['
        push!(s, [x, y, a])
    elseif v == ']'
        x, y, a = pop!(s)
        move_to(cr, x, y)
    end
end

stroke(cr);
write_to_png(c, "koch_$level.png");
