module xsh
using JSON
using UUID
# package code goes here
println(UUID.v4())

# JSON.parse - string or stream to Julia data structures
s = "{\"a_number\" : 5.0, \"an_array\" : [\"string\", 9]}"
j = JSON.parse(s)
#  Dict{String,Any} with 2 entries:
#    "an_array" => {"string",9}
#    "a_number" => 5.0
println(j)
# JSON.json - Julia data structures to a string
println(JSON.json([2,3]))
#  "[2,3]"
println(JSON.json(j))
#  "{\"an_array\":[\"string\",9],\"a_number\":5.0}"
end # module
