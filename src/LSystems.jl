module LSystems

export lindenmayer


function can_transition{T<:String, U<:Char}(transitions::Dict{U, T}, c::U)
    return haskey(transitions, c)
end

function transition{T<:String, U<:Char}(transitions::Dict{U, T}, c::U)
    return transitions[c]
end

function lindenmayer{T<:String, U<:Char, V<:Int}(start::T, transitions::Dict{U, T}, level::V)
    return lindenmayer(start, c -> can_transition(transitions, c), c -> transition(transitions, c), level)
end

function lindenmayer{T<:String, V<:Int}(start::T, transition_checker::Function, transition_function::Function, level::V)
    if level <= 0
        for c in start
            produce(c)
        end
    else
        for c in start
            if transition_checker(c)
                for v in @task lindenmayer(transition_function(c), transition_checker, transition_function, level - 1)
                    produce(v)
                end
            else
                produce(c)
            end
        end
    end
end

end # module
