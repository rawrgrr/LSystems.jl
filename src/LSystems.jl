module LSystems

export lindenmayer


function lindenmayer{T<:String, U<:Char, V<:Int}(start::T, transitions::Dict{U, T}, level::V)
    if level <= 0
        for c in start
            produce(c)
        end
    else
        for c in start
            if haskey(transitions, c)
                for v in @task lindenmayer(transitions[c], transitions, level - 1)
                    produce(v)
                end
            else
                produce(c)
            end
        end
    end
end

end # module
