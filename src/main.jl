export main

import Base:
REPL,
Terminals,
Vector,
println,
STDIN,
STDOUT,
STDERR,
pushdisplay,
VersionNumber,
print,
source_path

using ArgParse

function init_arg_table()

    s = ArgParseSettings(prog=XSH_BIN, description=XSH_ARG_DESCRIPTION, 
                         epilog=XSH_ARG_EPILOGUE, 
                         usage = XSH_ARG_USAGE,
                         version = "$(xsh.VERSION)",
                         add_help = false, 
                         add_version = false)

    @add_arg_table s begin
        "file"
        help = "Evaluate xsh script"
        "cmd"
        help = "Run command"
        action = :command
        "--help", "-h"
        help = "Print this message"
        action = :show_help
        "--version", "-v"
        help = "Display version information"
        action = :show_version
        "--quiet", "-q"
        help = "Quiet operation, only errors"
        action = :store_true
        "--verbose", "-V"
        help = "Specify verbosity level, 0≦V≦5 Default level [1]"
        action = :store_true
        "--debug", "-d"
        help = "Enable debug output"
        action = :store_true
        "--home", "-H"
        help = "Set the location of xsh home"
        action = :store_true
        "--interactive", "-i"
        help = "Run in interactive mode"
        action = :store_true
        "--login", "-l"
        help = "Run as a login shell"
        action = :store_true
        "--daemon", "-m"
        help = "Run and detach xsh daemon, then exit"
        action = :store_true
        "--ncpu", "-n"
        help = "Run [n] local processes"
        action = :store_true
        "--print", "-E"
        help = "Evaluate and show <cmd>"
        action = :store_true
        "--color", "-c"
        help = "Enable or disable color text"
        action = :store_true
        "--eval", "-e"
        help = "Evaluate <expr>"
        action = :store_true
        "--no-exec"
        help = "Do not execute, only perform syntax checking"
        action = :store_true
        "--no-history-file"
        help = "Do not archive command history"
        action = :store_true
        "--no-startup"
        help = "Do not load user start-up script [~/.xshrc]"
        action = :store_true
    end
    return s
end

function main(args::Vector{UTF8String}=UTF8String[])

    arg_parse_settings = init_arg_table()

    println(XSH_DESCRIPTION)
    parsed_args = parse_args(args, arg_parse_settings)
    println("Parsed args:")
    for (key,val) in parsed_args
        println("  $key  =>  $val")
    end
    # println(Base.source_path())
    # println("xsh"XSH_SYMBOL," v$(xsh.VERSION)")
    # global active_repl
    # active_repl = REPL.LineEditREPL(Terminals.TTYTerminal("xterm",STDIN,STDOUT,STDERR), true)
    # pushdisplay(REPL.REPLDisplay(active_repl))
    # REPL.run_repl(active_repl)

end
