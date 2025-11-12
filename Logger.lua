getLoader = function()
  if _ENV then
    return "load"
  else
    return "loadstring"
  end
end

local _g = setmetatable({}, {__index = _G, __newindex = _G})

local old = _G[getLoader()]
_G[getLoader()] = function(n,c)
  c=c or _VERSION
  local f,e = old(n,c)
  if f then
    return f
  else
    print("load error -> " .. e)
    return nil
  end
end

function table.concat(tb, co)
  if type(tb) ~= "table" then
    print("table.concat -> argument[1]  is not a table.")
    return
  end
  if type(co) ~= "string" then
    print("table.concat -> argument[2] is not an string, but it is expected, so its handled")
    co = co or ""
  end
  return _g.table.concat(tb,co)
end


function table.unpack(tb)
  if type(tb) ~= "table" then
    print("table.unpack -> argument[1]  is not a table.")
    return
  end
  return _g.table.unpack(tb)
end

function string.char(...)
  local Args = {...}
  for _, val in pairs(Args) do
    if val > 255 then
      print("string.char -> recv value over 255, reduce to 255")
      Args[_] = val % 256
    end
  end
  return _g.string.char(table.unpack(Args))
end
