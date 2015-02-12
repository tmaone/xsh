using BinDeps

@BinDeps.setup

libnames = ["libncurses"]
suffixes = ["", "-5.9", "5.9", "5.4"]
options = ["",""]
extensions = ["", ".a", ".so.5"]


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
