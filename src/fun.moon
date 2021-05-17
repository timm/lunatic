-- vim: ts=2 sw=2 et :

-- Misc utilities.
-- All this code get loaded into the global space

export *

-- ## File utils
-- ### Csv
-- Read a comma operated file, kill space and comments,
-- convert some strings to numerics. 
csv= (file)->
  stream = io.input(file)
  =>
    if x = io.read()
      x = x\gsub("[\t\r ]+","")\gsub("#.*","")
      [(tonumber(y) or y) for y in x\gmatch("([^,]+)")]
    else
      io.close(stream) and nil

-- ## Maths
-- ### Random numbers
-- If standard generators are not stable across different
-- platforms, then use this one.
class Rand
  now=nil
  new: =>
    @seed      = 10013
    @multipler = 16807.0
    @modulus   = 2147483647.0
    @@now = @
  park_miller_randomizer: =>
    @seed = (@multipler * @seed) % @modulus -- cycle=2,147,483,646
    @seed / @modulus 
  any: (lo=0,hi=1) => lo + (hi-lo)*@\park_miller_randomizer!

-- ## Meta functions
-- ### same
-- Do nothing, return something. 
same= (x) -> x

-- ### cli
-- Given a table of functions, use information
-- on the command like to decide which to run.
-- "?" means list the options, `x` means run `x`
-- otherwise, run all.

cli= (t) ->
  run = (x) -> print("-- "..x) or t[x]()
  a = sorted [x for x,_ in pairs t]
  if s = arg[1]
    if s=="?" [print(" - #{x}") for x in *a]
    else
      if t[s] then run(s) else print("?? Unknown '#{s}'")
  else
    [run s for s in *a]

-- ## Array Utils
-- Arrays have  indexes `1...max`.
-- ## Table Utils
-- Tables have arbitrary indexes
-- ### sorted
sorted= (t,f= (x,y) -> x < y) -> table.sort(t, f) or t

-- ## Print utils
-- ### say
-- Convert a table to a string, keys sorted alphabetically, 
-- ignoring private keys.
say= (t, out="") ->
  return tostring(t) if (t=={} or type(t) != "table")
  private= (s) -> type(s)=="string" and s\match"^_"
  out = (if t.__class then t.__class.__name else "").."{"
  sep= ""
  for k in *sorted [k for k,_ in pairs t when not private k]
    v   = t[k]
    tmp = (type(k) !="number" and ":#{k} #{say(v)}") or say(v)
    out ..= sep..tmp
    sep   = ", "
  out.."}"

-- ### said
-- Print a table, as a string
said= (x) -> print(say(x))

