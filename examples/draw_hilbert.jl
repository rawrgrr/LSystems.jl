using Cairo
using LSystems

c = CairoRGBSurface(964, 964);
cr = CairoContext(c);

save(cr);

set_source_rgb(cr, 1.0, 1.0, 1.0);
rectangle(cr, 0.0, 0.0, 964.0, 964.0);
fill(cr);

restore(cr);
save(cr);

x, y, a, d = 10., 10., 180, 15
set_line_width(cr, 1);
move_to(cr, x, y);

hilbert_start = "A"
hilbert_trans = Dict([
('A', "-BF+AFA+FB-"),
('B', "+AF-BFB-FA+")
])

function determine_new_position(x, y, a, d)
    x -= sind(a) * d
    y -= cosd(a) * d
    return x, y
end

level = 6
drawing_instructions = @task dol_system(hilbert_start, hilbert_trans, level)

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
write_to_png(c, "hilbert_$level.png");
