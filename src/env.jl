module env

import Base:
    ENV,
    string,
    _hasenv,
    length,
    show

# export 

get(key::AbstractString) = has(key) ? ENV[key] : ""
get(key::Symbol) = has(string(key)) ? ENV[string(key)] : ""
set(key::AbstractString, value::AbstractString) = ENV[key] = value
set(key::Symbol, value::Symbol) = ENV[string(key)] = string(value)
has(key::AbstractString) = _hasenv(key)
has(key::Symbol) = _hasenv(string(key))
length() = length(ENV)
show() = show(ENV)

export get, set, has, length, show

end
