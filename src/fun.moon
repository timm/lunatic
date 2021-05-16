#!/usr/bin/env moon
-- vim: ts=2 sw=2 et :

-- Misc utilities.
-- All this code get loaded into the global space
export *

-- ## Data header utils
-- ### weight, is?
weight= (s)-> if s\find"-" then -1  else 1
isKlass=(s)-> s\find"!"
isSkip= (s)-> s\find"?"
isNum=  (s)-> s\match"^[A-Z]"
isY=    (s)-> s\find"+" or s\find"-" or isKlass s 
isX=    (s)-> not isY s

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

-- ## Meta functions
-- ### same
-- Do nothing, return something. 
same= (x) -> x

-- ## Array Util
-- Arrays have  indexes `1...max`.
-- ## Table Utils
-- ### sorted
-- Tables have arbitrary indexes
sorted= (t,f= (x,y) -> x < y) -> table.sort(t,f) or t

-- ## Print utils

-- ### say
-- Convert a table to a string, keys sorted alphabetically, 
-- ignoring private keys.
say= (t) ->
  return tostring(t) if (t=={} or type(t) != "table")
  pub= (s) -> type(s)=="string" and not s\match"^_"
  out= (if t.__class then t.__class.__name else "").."{"
  sep= ""
  for k in *sorted [k for k,_ in pairs t when pub k]
    v     = t[k]
    tmp   = (type(k) !="number" and ":#{k} #{say(v)}") or say(v)
    out ..= sep..tmp
    sep   = " "
  out.."}"

-- ### said
-- Print a table, as a string
said= (x) -> print(say(x))

