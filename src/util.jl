module util

using Switch

export @enum

include("util.string.jl")
include("util.json.jl")
include("util.zip.jl")
include("util.uuid.jl")

macro enum(T,syms...)
    blk = quote
        immutable $(esc(T))
            n::Int32
            $(esc(T))(n::Integer) = new(n)
        end
        Base.show(io::IO, x::$(esc(T))) = print(io, $syms[x.n+1])
        Base.show(io::IO, x::Type{$(esc(T))}) = print(io, $(string("enum ", T, ' ', '(', join(syms, ", "), ')')))
    end
    for (i,sym) in enumerate(syms)
        push!(blk.args, :(const $(esc(sym)) = $(esc(T))($(i-1))))
    end
    push!(blk.args, :nothing)
    blk.head = :toplevel
    return blk
end

export @switch, @case, @default, break

end
