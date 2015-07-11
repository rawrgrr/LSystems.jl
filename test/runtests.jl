using LSystems
using Base.Test

# Algae-growth from https://en.wikipedia.org/wiki/L-system#Example_1:_Algae
algae_start = "A"
algae_transition = Dict([('A', "AB"), ('B', "A")])

s = ""
for c in @task lindenmayer(algae_start, algae_transition, 0)
    s *= string(c)
end
@test "A" == s

s = ""
for c in @task lindenmayer(algae_start, algae_transition, 1)
    s *= string(c)
end
@test "AB" == s

s = ""
for c in @task lindenmayer(algae_start, algae_transition, 5)
    s *= string(c)
end
@test "ABAABABAABAAB" == s

s = ""
for c in @task lindenmayer(algae_start, algae_transition, 7)
    s *= string(c)
end
@test "ABAABABAABAABABAABABAABAABABAABAAB" == s


# Pythagoras tree from https://en.wikipedia.org/wiki/L-system#Example_2:_Pythagoras_tree
pythagoras_start = "0"
pythagoras_transition = Dict([('1', "11"), ('0', "1[0]0")])

s = ""
for c in @task lindenmayer(pythagoras_start, pythagoras_transition, 3)
    s *= string(c)
end
@test "1111[11[1[0]0]1[0]0]11[1[0]0]1[0]0" == s


# Koch curve from https://en.wikipedia.org/wiki/L-system#Example_4:_Koch_curve
koch_curve_start = "F"
koch_curve_transition = Dict([('F', "F+F-F-F+F")])

s = ""
for c in @task lindenmayer(koch_curve_start, koch_curve_transition, 2)
    s *= string(c)
end
@test "F+F-F-F+F+F+F-F-F+F-F+F-F-F+F-F+F-F-F+F+F+F-F-F+F" == s
