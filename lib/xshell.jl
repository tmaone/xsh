
if haskey(ENV,"XSHELL_BUILD")
    # if haskey(ENV,"JULIA_PKGDIR")
    #     push!(LOAD_PATH, ENV["JULIA_PKGDIR"])    
    # end
    
    if false
    # simple print definitions for debugging. enable these if something
    # goes wrong during bootstrap before printing code is available.
    show(x::ANY) = ccall(:jl_static_show, Void, (Ptr{Void}, Any),
                         Intrinsics.pointerref(Intrinsics.cglobal(:jl_uv_stdout,Ptr{Void}),1), x)
    print(x::ANY) = show(x)
    println(x::ANY) = ccall(:jl_, Void, (Any,), x)
    print(a::ANY...) = for x=a; print(x); end
    info(a::ANY...) = for x=a; print(x); end
    info(x::ANY) = show(x)
    warn(a::ANY...) = for x=a; print(x); end
    warn(x::ANY) = show(x)
    error(a::ANY...) = for x=a; print(x); end
    error(x::ANY) = show(x)
    end

    include("../../deps/deps.jl")
    include("../imports.jl")

else
    include("../deps/deps.jl")
    # include("includes.jl")
end

@osx_only push!(DL_LOAD_PATH, "@executable_path/../lib/xshell")
@osx_only push!(DL_LOAD_PATH, "@executable_path/../lib")

baremodule xshell

module os
type one
end
end # module

module shell
type two
end
end # module

end # baremodule xshell

using xshell

function xsh_start()
    info("xshell ->!")
    Base.versioninfo()
    function input(prompt::String="")
         print(prompt)
         chomp(readline(STDIN))
    end
    while true
        inputs = input(">");
        # Base.REPL.eval_user_input(string(input))
        println(inputs)
        # println(eval(input))
        # ARGS=[]
        # Base._start()
    end
end

if !haskey(ENV,"XSHELL_BUILD")
   xsh_start()
end

# Base._start()

# if Base.samefile(Sys.dlpath(sysimg), "$(xshell_sysimg_path).$(Sys.dlext)")
#     println("adsdasdasdasdadasdas")
# end

# 
# include("os.jl")


# const julia_sysimg_path = joinpath(dirname(Sys.dlpath("libjulia")),"sys")

# sysimg = dlopen_e("sys")

# if Base.samefile(Sys.dlpath(sysimg), "$(julia_sysimg_path).$(Sys.dlext)")
#     include("../includes.jl")
# else
#     const xshell_sysimg_path = joinpath(dirname(Sys.dlpath("libxshell")),"xshell-sys")
#     println("Devel xshell image...")
#     include("includes.jl")
#     println("alt!")
# end
