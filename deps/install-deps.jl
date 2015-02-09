include("deps.jl")

if !haskey(ENV,"UPDATE")

    Pkg.init()

    for dep in xhell_base_dependencies
        dependency = string(dep)
        info("Installing Base Dependency [", dependency, ".jl]")
        if !isdir(Pkg.dir(dependency))
            Pkg.clone(string(dependency))
        end
    end

    for dep in xhell_base_dependencies
        dependency = string(dep)
        info("Building Base Dependency [", dependency, ".jl]")
        if isdir(Pkg.dir(dependency))
            Pkg.build(string(dependency))
        end
    end

    for dep in xshell_dependencies
        dependency = string(dep)
        info("Installing xshell Dependency [", dependency, ".jl]")
        if !isdir(Pkg.dir(dependency))
            Pkg.clone(string(dependency))
        end
    end

    for dep in xshell_dependencies
        dependency = string(dep)
        info("Building xshell Dependency [", dependency, ".jl]")
        if isdir(Pkg.dir(dependency))
            Pkg.build(string(dependency))
        end
    end

    Pkg.update()

    # Pkg.build(string(dep));
    # Pkg.build(xhell_base_dependencies);
    # Pkg.build(xshell_dependencies);

else
    Pkg.update()
end

# Pkg.status()
# println(Pkg.installed())
# Pkg.init();
# Pkg.update();
# Pkg.clone("AudioIO")
# julia> Pkg.build("AudioIO")
# println("Installing Dependency [BinDeps] in: [", Pkg.dir("BinDeps"), "]");
# Pkg.add("BinDeps");
# println("Installing Dependency [Color] in: [", Pkg.dir("Color"), "]");
# Pkg.add("Color");
