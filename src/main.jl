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
    print

using ArgParse

function main(args::Vector{UTF8String}=UTF8String[])
    s = ArgParseSettings("Example 3 for argparse.jl: " *
                         "version info, default values, " *
                         "options with types, variable " *
                         "number of arguments.",
                         version = "v$(xsh.VERSION)", # version info
                         add_version = true)      # audo-add version option
    
    @add_arg_table s begin
        "--opt1"
            help = "an option"     # used by the help screen
        "--opt2", "-o"
            action = :store_true   # this makes it a flag
            help = "a flag"
        "arg1"
            help = "an argument"
            required = false        # makes the argument mandatory
    end

    parsed_args = parse_args(args, s)
    println("Parsed args:")
    for (key,val) in parsed_args
        println("  $key  =>  $val")
    end

    println("xsh"XSH_PROMPT_CHAR," v$(xsh.VERSION)")
    global active_repl
    active_repl = REPL.LineEditREPL(Terminals.TTYTerminal("xterm",STDIN,STDOUT,STDERR), true)
    pushdisplay(REPL.REPLDisplay(active_repl))
    REPL.run_repl(active_repl)
end
