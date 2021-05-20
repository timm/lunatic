---
title: "col.moon"
---


Generic stuff for all columns.

```moonscript
import is from require "is"
class Col
  new: (at=1,txt='') => 
    @at, @txt = at, txt
    @w = is.weighted(txt) -- if txt has "<" then weight=-1
    @n, @rank = 0, 0
  adds: (a) => [@\add(x) for x in *a]
  add:  (x,n=1) =>
    if x != "?"   -- ignore missing values
      @n += n     -- otherwise, increment counter 
      @\add1 x,n  -- and summarize.
```

## distance

```moonscript
  norm: (x)   =>  x=="?" and x or @\norm1 x
  dist: (x,y) =>  (x=="?" and y=="?") and  1 or @\dist1(x,y)
```

Here we need to handle missing values.
If both values are missing the
[Aha](refs#Aha91) advises to assume the worst and give
maximum distance.
## Skip
Anything sent to `Skip` just gets ignored.

```moonscript
class Skip extends Col
  add1: (x,_) => x
  report: (w=20,r=1) => fmt("%#{x}s : ...",@txt)
```

## exports

```moonscript
:Col, :Skip
```
