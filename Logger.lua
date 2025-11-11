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
    print("load error : " .. e)
    return nil
  end
end

function string.char(...)
  local Args = {...}
  for _, val in pairs(Args) do
    if val > 255 then
      Args[_] = val % 256
    end
  end
  return _g.string.char(table.unpack(Args))
end
