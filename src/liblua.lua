-- Iterate on keys in sorted order
local function order(t,  i,keys)
  i,keys = 0,{}
  for key,_ in pairs(t) do keys[#keys+1] = key end
  table.sort(keys)
  return function ()
    if i < #keys then
      i=i+1; return keys[i], t[keys[i]] end end end 

-- "C"-like printf
local function printf(...) print(string.format(...)) end

-- Simple print of a flat table
local function o(z,pre) print(ooo(z,pre)) end

-- Simple translation table to string.
local function ooo(z,pre,   s,c) 
  s, c = (pre or "")..'{', ""
  for _,v in order(z or {}) do s= s..c..tostring(v); c=", " end
  return s..'}' end

-- Nested translation table to string.
-- Don't show private slots (those that start with `_`);
-- show slots in sorted order;
-- if `pre` is specified, then  print that as a prefix.
local function oo(t,pre,    indent,f)
  pre    = pre or ""
  indent = indent or 0
  if(indent==0) then print("") end
  if indent < 10 then
    for k, v in order(t or {}) do
      if not (type(k)=='string' and k:match("^_")) then
        if not (type(v)=='function') then
          f = pre..string.rep("|  ",indent)..tostring(k).." "
          if type(v) == "table" then
            print(f)
            oo(v, pre, indent+1)
          else
            print(f .. tostring(v)) end end end end end end

return { printf=printf, o=o, oo=oo, ooo=ooo}
