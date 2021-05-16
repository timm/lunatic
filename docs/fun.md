---
title: "fun.moon"
---


Misc utilities.
All this code get loaded into the global space

```moonscript
export *
```

## Data header utils
### weight, is?

```moonscript
weight= (s)-> if s\find"-" then -1  else 1
isKlass=(s)-> s\find"!"
isSkip= (s)-> s\find"?"
isNum=  (s)-> s\match"^[A-Z]"
isY=    (s)-> s\find"+" or s\find"-" or isKlass s 
isX=    (s)-> not isY s
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

## Meta functions
### same
Do nothing, return something. 

```moonscript
same= (x) -> x
```

## Array Util
Arrays have  indexes `1...max`.
## Table Utils
### sorted
Tables have arbitrary indexes

```moonscript
sorted= (t,f= (x,y) -> x < y) -> table.sort(t,f) or t
```

## Print utils

```moonscript
```

### say
Convert a table to a string, keys sorted alphabetically, 
ignoring private keys.

```moonscript
say= (t) ->
  public= (s) -> type(s)=="string" and not s\match"^_"
  return tostring(t) if t=={} or type(t) != "table"
  out = (if t.__class then t.__class.__name else "").."{"
  sep=""
  for k in *sorted([k for k in pairs t when public k])
    v = t[k]
    out ..= sep..(type(k) != "number" and ":#{k} #{say(v)}" or say(v))
    sep = " "
  out.."}"
```

### sayln
Print a table, as a string

```moonscript
sayln= (x) -> print(say(x))
```
