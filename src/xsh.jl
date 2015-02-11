#!/usr/bin/env julia

baremodule xsh

import Base:
    include,
    isfile

importall Base.Operators

eval(x) = Core.eval(xsh, x)
eval(m,x) = Core.eval(m, x)

include("version.jl")
if isfile("build_h.jl")
    include("build_h.jl")
end
include("common.jl")
include("env.jl")
include("lib.jl")


include("arg.jl")
include("cd.jl")
include("clock.jl")
include("color.jl")
include("commands.jl")
include("complete.jl")
include("config.jl")
include("daemon.jl")
include("debug.jl")
include("dir.jl")
include("disk.jl")
include("download.jl")
include("edit.jl")
include("error.jl")
include("file.jl")
include("find.jl")
include("funct.jl")
include("git.jl")
include("help.jl")
include("history.jl")
include("host.jl")
include("jobs.jl")
include("key.jl")
include("locate.jl")
include("log.jl")
include("mouse.jl")
include("net.jl")
include("os.jl")
include("path.jl")
include("plugin.jl")
include("process.jl")
include("profile.jl")
include("program.jl")
include("prompt.jl")
include("read.jl")
include("repl.jl")
include("settings.jl")
include("src.jl")
include("source.jl")
include("task.jl")
include("term.jl")
include("user.jl")
include("util.jl")
include("wd.jl")
include("window.jl")
include("xshell.jl")
include("main.jl")

end

using xsh

if !haskey(ENV,"BUILD") && !haskey(ENV,"TESTING")
    main(ARGS)
end

# end

# using xsh



# # using Base.Terminals
# # using Base.REPL
# # const msg = Base.eval("xsh"string(char(0xb83))" ")

# # function main(args::Vector{UTF8String}=UTF8String[])
# #     Base.println(xsh.XSH_PROMPT_CHAR,"v$(xsh.VERSION)")
# #     function input(prompt::String="")
# #          print(prompt)
# #          chomp(readline(STDIN))
# #     end
# #     for a in ARGS
# #         println("arg: [$(a)]")
# #     end
# #     while true
# #         # inputs = input("$(msg)");
# #         # Base.println(inputs)
# #         global active_repl
# #         active_repl = Base.REPL.LineEditREPL(Terminals.TTYTerminal("xterm",STDIN,STDOUT,STDERR), true)
# #         Base.pushdisplay(Base.REPL.REPLDisplay(active_repl))
# #         Base.REPL.run_repl(active_repl)
# #     end
# # end

# # if !haskey(ENV,"BUILD") && !haskey(ENV,"TESTING")
# #     main(ARGS)
# # else
# #     local term
# #     global active_repl
# #     term = Base.Terminals.TTYTerminal(get(ENV,"TERM",@windows? "" : "dumb"),STDIN,STDOUT,STDERR)
# #     active_repl = Base.REPL.LineEditREPL(term, true)
# #     pushdisplay(Base.REPL.REPLDisplay(active_repl))
# #     Base.REPL.run_repl(active_repl)
# #     # Base._start()
# # end

# # import Base
# # export main
# # using Base:
# #     include

# # baremodule xsh


# # Base.include("common.jl")
# # Base.include("string.jl")

# # end

# # using xsh

# # println(xsh_version)

# # module xsh
# # using JSON
# # using UUID
# # # package code goes here
# # println(UUID.v4())

# # # JSON.parse - string or stream to Julia data structures
# # s = "{\"a_number\" : 5.0, \"an_array\" : [\"string\", 9]}"
# # j = JSON.parse(s)
# # #  Dict{String,Any} with 2 entries:
# # #    "an_array" => {"string",9}
# # #    "a_number" => 5.0
# # println(j)
# # # JSON.json - Julia data structures to a string
# # println(JSON.json([2,3]))
# # #  "[2,3]"
# # println(JSON.json(j))
# # #  "{\"an_array\":[\"string\",9],\"a_number\":5.0}"
# # msg = "xsh"string(char(0xb83))" "
# # println(msg)

# # function _start(ARGS)
# #     println(msg)
# #     Base.versioninfo()
# #     function input(prompt::String="")
# #          print(prompt)
# #          chomp(readline(STDIN))
# #     end
# #     for a in ARGS
# #         println(a)
# #     end
# #     # while true
# #         # inputs = input(">");
# #         # println(inputs)
# #     # end
# # end

# # function test(in::String)
# #     println(msg, "$(in)")
# # end

# # end # module



# # baremodule core

# # using xsh

# # xsh.test("core")
# # end

# #baremodule file

# # using xsh
# # xsh.test("file")
# # end

# # baremodule color

# # using xsh
# # xsh.test("color")
# # end

# # # import xsh

# # # if !haskey(ENV,"XSH_BUILD")
# # #    xsh._start(:NULL)
# # # end

