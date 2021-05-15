---
title: "fun.moon"
---


## Misc Utils
All this code get loaded into the global space

```moonscript
export *
```

### Data header utils

```moonscript
weight= (s)-> if s\find"-" then -1  else 1
isKlass=(s)-> s\find"!"
isSkip= (s)-> s\find"?"
isNum=  (s)-> s\match"^[A-Z]"
isY=    (s)-> s\find"+" or s\find"-" or isKlass s 
isX=    (s)-> not isY s
```

### CSV reader
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

### Meta functions
Do nothing, return something

```moonscript
same: (x) -> x
```

Return `true`  if not a table

```moonscript
atom: (x) -> 
  return true if type(x)=="number" or type(x)=="string"
  return true if x=={} or x==true or x=false or x=nil
  return false
```

### Array Util
Arrays have  indexes `1...max`.
### Table Utils
Tables have arbitrary indexes

```moonscript
sorted: (t,f= (x,y) -> x < y) = table.sort(t,f) or t
```

### Print utils
Print something, then return it.

```moonscript
say= (s,x) -> print(s,x) and x
```

Print a table, keys sorted alphabetically, ignoring
private keys.

```moonscript
show: (t,   out="") ->
  return tostring(t) if atom(t)
  public: (s) -> type(s)=="string" and not s\match"^_"
  for k in *sorted([k for k in in pairs t when public s])
    v = t[k]
    out ..= (type(v) != "number" and " :{k} {show(v)}" or show(v))
```
