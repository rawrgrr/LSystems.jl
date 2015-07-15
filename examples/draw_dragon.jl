using Cairo
using LSystems

c = CairoRGBSurface(485, 720);
cr = CairoContext(c);

save(cr);

set_source_rgb(cr, 1.0, 1.0, 1.0);
rectangle(cr, 0.0, 0.0, 485.0, 720.0);
fill(cr);

restore(cr);
save(cr);

x, y, a, d = 310., 560., 90, 15
set_line_width(cr, 1);
move_to(cr, x, y);

dragon_start = "A"
dragon_trans = Dict([
('A', "A+BF"),
('B', "FA-B")
])

function determine_new_position(x, y, a, d)
    x -= sind(a) * d
    y -= cosd(a) * d
    return x, y
end

level = 10
drawing_instructions = @task dol_system(dragon_start, dragon_trans, level)

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
write_to_png(c, "dragon_$level.png");
