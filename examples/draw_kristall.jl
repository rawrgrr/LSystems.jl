using Cairo
using LSystems
using DataStructures

c = CairoRGBSurface(704, 1024);
cr = CairoContext(c);

save(cr);

set_source_rgb(cr, 1.0, 1.0, 1.0);
rectangle(cr, 0.0, 0.0, 704.0, 1024.0);
fill(cr);

restore(cr);
save(cr);

x, y, a, d = 352., 992., 0, 4
set_line_width(cr, 0.6);
move_to(cr, x, y);

kristall_start = "F"
kristall_trans = Dict([('F', "F+F--f+F-F++f-F"), ('f', "fff")])

function determine_new_position(x, y, a, d)
    x -= sind(a) * d
    y -= cosd(a) * d
    return x, y
end

s = Stack(Vector{Float64}) # [x, y, a]

level = 5
drawing_instructions = @task lindenmayer(kristall_start, kristall_trans, level)

for v in drawing_instructions
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
write_to_png(c, "kristall_$level.png");
