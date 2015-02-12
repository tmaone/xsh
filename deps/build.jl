using BinDeps

@BinDeps.setup

ncurses = library_dependency(
    "libncurses",
    aliases = ["libncurses", "libncurses-5.9"]
    )

provides(Sources, {
    URI("http://ftp.gnu.org/pub/gnu/ncurses/ncurses-5.9.tar.gz") => ncurses
    })

provides(
    BuildProcess,
    Autotools(libtarget = "libncurses.a"),
    ncurses,
    os = :Unix
    )

@osx_only begin
    using Homebrew
    provides(Homebrew.HB, {"libncurses" => libncurses})
end

@BinDeps.install [:libncurses => :libncurses]
