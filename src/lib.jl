module lib

type Library
    name::Symbol
    lib_name::ASCIIString
    lib_obj
    loaded::Bool
    Library(name::Symbol, lib_name::ASCIIString) =
    new(name,lib_name,C_NULL,false)
end

libraries = Dict{Symbol, Library}()

export load_lib, add_lib, get_lib, loaded, libraries, Library

    # function to load a library
    function add_lib(lib::Library)
        if !haskey(libraries, lib.name) 
            setindex!(libraries, lib, lib.name )
        else
            warn("Already in libraries: \n\n$lib.lib_name\n")
        end
    end

    # function to load a library
    function get_lib(name::Symbol)
        if haskey(libraries, name)
            if loaded(name)
                return libraries[name].lib_obj
            else
                load_lib(name)
                return libraries[name].lib_obj
            end
        else
            warn("Does not exist: \n\n$libraries[name].lib_name\n")
        end
    end

    # function to load a library
    function load_lib(name::Symbol)
        if haskey(libraries, name)
            if !loaded(name)
                libraries[name].lib_obj = dlopen(libraries[name].lib_name)
                if libraries[name].lib_obj == C_NULL
                    error("Unable to load \n\n$libraries[name].lib_name\n")
                end
                libraries[name].loaded=true
            else
                warn("Already loaded: \n\n$libraries[name].lib_name\n")
            end
        else
            warn("Cannot find library: \n\n$libraries[name].lib_name\n")
        end
    end

    # function to load a library
    function loaded(name::Symbol)
        if haskey(libraries, name)
            return libraries[name].loaded
        else
            warn("Does not exist: \n\n$libraries[name].lib_name\n")
        end
    end

    include("lib/ncurses.jl")

end
