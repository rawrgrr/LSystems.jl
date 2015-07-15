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

x, y, a, d = 50., 512., 0, 15
set_line_width(cr, 0.6);
move_to(cr, x, y);

sierpinski_start = "F+XF+F+XF"
sierpinski_trans = Dict([('X', "XF-F+F-XF+F+XF-F+F-X")])

function determine_new_position(x, y, a, d)
    x -= sind(a) * d
    y -= cosd(a) * d
    return x, y
end

s = Stack(Vector{Float64}) # [x, y, a]

level = 4
drawing_instructions = @task lindenmayer(sierpinski_start, sierpinski_trans, level)

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
write_to_png(c, "sierpinski_$level.png");
