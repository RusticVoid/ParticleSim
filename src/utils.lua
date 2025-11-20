function getDistance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

function matrixSpacing(input)
    if input == 0 then
        return " 0"
    elseif input == 1 then
        return " 1"
    else
        return input
    end
end

function addColor(colorName, color)
    colors[#colors+1] = colorName
    colorMatrix[colorName] = {}
    for i = 1, #colors do
        colorMatrix[colorName][colors[i]] = math.random(-1, 1)
    end
    for i = 1, #colors do
        colorMatrix[colors[i]][colorName] = math.random(-1, 1)
    end 
    colorMatrix[colorName]["color"] = color
end

function printMatrix()
    top = ""
    for i = 1, #colors do
        top = top.." : "..colors[i]:sub(1,1)
    end
    print(" "..top)

    for i = 1, #colors do
        row = colors[i]:sub(1,1)
        for y = 1, #colors do
            row = row.." :"..matrixSpacing(colorMatrix[colors[i]][colors[y]])
        end
        print(row)
    end
end

function randomColor()
    local randColor = math.random(1, #colors)
    return colors[randColor]
end