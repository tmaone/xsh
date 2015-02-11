module colour

using Color, Compat

    const color_names = Color.color_names

    function getcolor(name::ASCIIString)
        return color_names[name]
    end


    function __init__()
        println(getcolor("red"))
    end

end

