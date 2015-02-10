module env

import Base:
    ENV,
    string,
    _hasenv,
    length,
    show

get(key::AbstractString) = ENV[key]
get(key::Symbol) = ENV[string(key)]
set(key::AbstractString, value::AbstractString) = ENV[key] = value
set(key::Symbol, value::Symbol) = ENV[string(key)] = string(value)
has(key::AbstractString) = _hasenv(key)
has(key::Symbol) = _hasenv(string(key))
length() = length(ENV)
show() = show(ENV)

USER = get("USER")
SHELL = get("SHELL")
HOME = get("HOME")
PATH = get("PATH")
PWD = get("PWD")
TERM = get("TERM")
TMPDIR = get("TMPDIR")

end
