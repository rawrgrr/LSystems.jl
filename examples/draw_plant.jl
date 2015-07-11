using Cairo
using LSystems
using DataStructures

c = CairoRGBSurface(1024, 896);
cr = CairoContext(c);

set_source_rgb(cr, 1.0, 1.0, 1.0);
rectangle(cr, 0.0, 0.0, 1024.0, 896.0);
fill(cr);

x, y, a, d = 64., 896., -pi / 6, 0.8 #0.03
move_to(cr, x, y);
set_line_width(cr, 0.6);

plant_start = "X" # F−[[X]+X]+F[+FX]−X
plant_trans = Dict([('X', "F-[[X]+X]+F[+FX]-X"), ('F', "FF")])

function determine_new_position(x, y, a, d)
    x -= sin(a) * d
    y -= cos(a) * d
    return x, y
end

s = Stack(Vector{Float64}) # [x, y, angle]

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

stroke (cr);
write_to_png(c, "plant_9.png");
