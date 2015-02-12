using BinDeps

@BinDeps.setup

libnames = ["libncurses", "libncursesw", "libncursestw"]
suffixes = ["", "-5.9", "5.9", "5.4", "6", ".6."]
options = [""]
extensions = ["", ".a", ".so.5", ".dylib"]
aliases = vec(libnames.*transpose(suffixes).*reshape(options,(1,1,length(options))).*reshape(extensions,(1,1,1,length(extensions))))

libncurses = library_dependency("libncurses", aliases = aliases)

provides(Sources, {
    URI("http://ftp.gnu.org/pub/gnu/ncurses/ncurses-5.9.tar.gz") => libncurses
    })

@linux_only begin
    provides(AptGet, "libncurses", libncurses)
    provides(AptGet, "libncurses", libncurses)
    provides(Pacman, "libncurses", libncurses)
    provides(Yum, "libncurses", libncurses)
end

# TODO: remove me when upstream is fixed
@windows_only error("Not supported")

@osx_only begin
    if Pkg.installed("Homebrew") === nothing
            error("Homebrew package not installed, please run Pkg.add(\"Homebrew\")")
    end
    # using Homebrew
    # provides( Homebrew.HB, "homebrew/dupes/ncurses", libncurses, os = :Darwin, onload =
    # """
    # function __init__()

    # end
    # """)
    # provides(SimpleBuild,
    #     (@build_steps begin
    #         ChangeDirectory(Pkg.Dir.path("xsh"))
    #         @build_steps begin
    #             ChangeDirectory(Pkg.Dir.path("xsh","deps","formulae"))
    #             `brew -vvv install ncurses.rb`
    #         end)
    #     end),[libncurses], os = :Darwin)
end

@BinDeps.install Dict([(:libncurses, :libncurses)])

# Save the library version; by checking this now, we avoid a runtime dependency on libwand
# See https://github.com/timholy/Images.jl/issues/184#issuecomment-55643225
module CheckVersion
include("deps.jl")
if isdefined(:__init__)
    __init__()
end
p = ccall((:MagickQueryConfigureOption, libwand), Ptr{Uint8}, (Ptr{Uint8},), "LIB_VERSION_NUMBER")
vstr = string("v\"", join(split(bytestring(p), ',')[1:3], '.'), "\"")
open(joinpath(dirname(@__FILE__),"versioninfo.jl"), "w") do file
    write(file, "const libversion = $vstr\n")
end
end

# ncurses = library_dependency(
#     "libncurses",
#     aliases = ["libncurses", "libncurses-5.9"]
#     )

# provides(Sources, {
#     URI("http://ftp.gnu.org/pub/gnu/ncurses/ncurses-5.9.tar.gz") => ncurses
#     })

# provides(
#     BuildProcess,
#     Autotools(libtarget = "libncurses.a"),
#     ncurses,
#     os = :Unix
#     )

# @osx_only begin
#     using Homebrew
#     provides(Homebrew.HB, {"libncurses" => libncurses})
# end

# @BinDeps.install [:libncurses => :libncurses]
