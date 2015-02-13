module colour

using ..lib.nc
using ..util
using ..util.string

using Color, Color.names
using Compat

colour_config = Dict(
:FOREGROUND => :whitesmoke,
:BACKGROUND => :black,
:HIGHLIGHT => :yellow,
:BOLD => :white,
:LINKS => :blue,
:SELECTION => :blue,
:SELECTED_TEXT => :brightblue,
:BADGE => :brightblue,
:BORDER => :grey,
:CURSOR => :grey,
:CURSOR_TEXT => :darkgrey,
:DEBUG => :darkgray,
:INFO => :white,
:WARN => :yellow,
:EXCEPTION => :yellow,
:ERROR => :red,
:PROMPT => :white,
:ANSI_BLACK => :black,
:ANSI_BRIGHT_BLACK => :black,
:ANSI_RED => :red,
:ANSI_BRIGHT_RED => :red,
:ANSI_GREEN => :green,
:ANSI_BRIGHT_GREEN => :green,
:ANSI_YELLOW => :yellow,
:ANSI_BRIGHT_YELLOW  => :yellow,
:ANSI_BLUE => :blue,
:ANSI_BRIGHT_BLUE => :blue,
:ANSI_MAGENTA => :magenta,
:ANSI_BRIGHT_MAGENTA => :magenta,
:ANSI_CYAN => :cyan,
:ANSI_BRIGHT_CYAN  => :cyan,
:ANSI_WHITE=> :white,
:ANSI_BRIGHT_WHITE => :white
)

type TColor
    name::Symbol
    color_name::ASCIIString
    red::Int
    green::Int
    blue::Int
    idx::Int
    TColor(name::ASCIIString, index::Int, r::Int, g::Int, b::Int) =
    new(string2symbol(name), name, r, g, b, index)
end

const colorNames = Dict{Symbol, TColor}()
const colorIndexes = Dict{Int, TColor}()

function rgb2nc(r::Int, g::Int, b::Int)
    local red, green, blue 
    local rat = 1000/255
    red = r*rat
    green = g*rat
    blue = b*rat
    int(red), int(green), int(blue)
end

function load_color_symbols()

    idx = 1
    for color_name in keys(Color.color_names)
        r, g, b = Color.color_names["$color_name"]
        r, g, b = rgb2nc(r,g,b)
        col = TColor("$color_name", idx, r, g, b)
        setindex!(colorNames, col, col.name)
        setindex!(colorIndexes, col, idx)
        idx=idx+1
    end

    for color in keys(colour_config)
        # println("$colorNames[colour_config[color]]")
        # println(colorNames[colour_config[color]])
    end

end

function color(color_symbol::Symbol)
    colorNames[color_symbol].idx
end

function color(idx::Int)
    colorIndexes[idx].name
end

    # function getcolor(name::ASCIIString)
        # return color_names[name]
    # end

    function init_nc_colors()
        for idx in keys(colorIndexes)
            init_color(idx, colorIndexes[idx].red, colorIndexes[idx].green, colorIndexes[idx].blue)
        end
    end
    
    function __init__()
        load_color_symbols()
    end

end
