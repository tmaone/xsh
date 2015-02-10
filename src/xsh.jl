#!/usr/bin/env julia

module xsh

    const msg = "xsh"string(char(0xb83))" "

function main(args::Vector{UTF8String})
    println(msg)
    function input(prompt::String="")
         print(prompt)
         chomp(readline(STDIN))
    end
    for a in ARGS
        println("arg: [$(a)]")
    end
    while true
        inputs = input("$(msg)");
        # println(inputs)
    end
end

end

using xsh

if !haskey(ENV,"BUILD")
   xsh.main(ARGS)
end

# import Base

# using Base:
#     include

# baremodule xsh


# Base.include("common.jl")
# Base.include("string.jl")

# end

# using xsh

# println(xsh_version)

# module xsh
# using JSON
# using UUID
# # package code goes here
# println(UUID.v4())

# # JSON.parse - string or stream to Julia data structures
# s = "{\"a_number\" : 5.0, \"an_array\" : [\"string\", 9]}"
# j = JSON.parse(s)
# #  Dict{String,Any} with 2 entries:
# #    "an_array" => {"string",9}
# #    "a_number" => 5.0
# println(j)
# # JSON.json - Julia data structures to a string
# println(JSON.json([2,3]))
# #  "[2,3]"
# println(JSON.json(j))
# #  "{\"an_array\":[\"string\",9],\"a_number\":5.0}"
# msg = "xsh"string(char(0xb83))" "
# println(msg)

# function _start(ARGS)
#     println(msg)
#     Base.versioninfo()
#     function input(prompt::String="")
#          print(prompt)
#          chomp(readline(STDIN))
#     end
#     for a in ARGS
#         println(a)
#     end
#     # while true
#         # inputs = input(">");
#         # println(inputs)
#     # end
# end

# function test(in::String)
#     println(msg, "$(in)")
# end

# end # module



# baremodule core

# using xsh

# xsh.test("core")
# end

#baremodule file

# using xsh
# xsh.test("file")
# end

# baremodule color

# using xsh
# xsh.test("color")
# end

# # import xsh

# # if !haskey(ENV,"XSH_BUILD")
# #    xsh._start(:NULL)
# # end

