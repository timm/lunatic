---
title: "fun.moon"
---


Misc utilities.

```moonscript
moon  = require "moon"
```

## File utils
### Csv
Read a comma operated file, kill space and comments,
convert some strings to numerics. 

```moonscript
csv= (file)->
  stream = io.input(file)
  =>
    if x = io.read()
      x = x\gsub("[\t\r ]+","")\gsub("#.*","")
      [(tonumber(y) or y) for y in x\gmatch("([^,]+)")]
    else
      io.close(stream) and nil
```

## Maths
### Random numbers
If standard generators are not stable across different
platforms, then use this one.

```moonscript
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
  any: (lo=0, hi=1) => lo + (hi-lo)*@\park_miller_randomizer!
```

## Meta functions
### same
Do nothing, return something. 

```moonscript
same= (x) -> x
```

### cli
Given a table of functions, use information
on the command like to decide which to run.
"?" means list the options, `x` means run `x`
otherwise, run all.

```moonscript
colors={}
sorted=nil
cli= (t) ->
  run = (x) -> 
    print colors.fmt {green: "-- ".. x} 
    t[x]()
  a = sorted [x for x,_ in pairs t]
  if s = arg[1]
    if s=="?" [print(" - #{x}") for x in *a]
    else
      if t[s] then run(s) else print("?? Unknown '#{s}'")
  else
    [run s for s in *a]
```

## Array Utils
Arrays have  indexes `1...max`.
### sum(a, filter=same) 

```moonscript
sum= (a,filter=same, s=0) ->
   for x in *a do s += filter(x)
   s
```

## Table Utils
Tables have arbitrary indexes
### sorted

```moonscript
sorted= (t,f= (x,y) -> x < y) -> table.sort(t, f) or t
```

## Print utils
### fmt
Generate a string.

```moonscript
fmt= (...) ->  string.format(...)
```

### prinft
Print  a generated script

```moonscript
fmtln= (...) -> print(fmt(...))
```

### cat
Shorthand for table.cocat

```moonscript
cat= (a, sep=", ") -> table.concat(a,sep)
```

### say
Convert a table to a string, keys sorted alphabetically, 
ignoring private keys.

```moonscript
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
```

### said
Print a table, as a string

```moonscript
said= (x) -> print(say(x))
```

### colors

```moonscript
colors = 
  nc:      "[0m" -- No Color
  bold:    "[1m" -- Bold
  black:   "[0;30m"
  gray:    "[1;30m"
  red:     "[0;31m"
  green:   "[0;32m"
  yellow:  "[0;33m"
  blue:    "[0;34m"
  magenta: "[0;35m"
  cyan:    "[0;36m"
  white:   "[0;37m"
colors.fmt = (t) ->
  e  = string.char 27
  b  = "#{e}#{colors.bold}"
  for c,s in pairs t
    return "#{e}#{colors[c]}#{b}#{s}#{e}#{colors.nc}"
```

## exports

```moonscript
{:csv, :Rand, :same, :cli, :sum, :sorted,
 :fmt, :fmtln, :cat, :say, :said }
```
