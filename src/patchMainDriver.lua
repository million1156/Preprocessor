local DriverFile = remodel.readModelFile("out/Driver.rbxm")[1]

local split = string.split or function (inputstr, sep)
    if sep == nil then
       sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
       table.insert(t, str)
    end
    return t
end

local source = remodel.getRawProperty(DriverFile, "Source")
local lines = split(source, "\n")
local newSource = {}


local temp = remodel.readFile("build/models.temp.txt")
for i, line in pairs(lines) do
    newSource[i] = line

    if line:find('local input') then
        newSource[i] = "	local input = '" .. temp .. "'"
    end
end

remodel.setRawProperty(DriverFile, "Source", "String", table.concat(newSource, "\n"))
remodel.writeModelFile("out/Driver.rbxm", DriverFile)