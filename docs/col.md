---
title: "col.moon"
---


Tools for summarizing data.

```moonscript
require "fun"
is=require "is"
```

## Col
Generic stuff for all columns.

```moonscript
class Col
  new: (at=1,txt='') => 
    @n, @at, @txt, @w = 0, at, txt, is.weighted(txt)
  adds: (a) => [@\add(x) for x in *a]
  add:  (x) =>
    if x != "?" 
      @n += 1
      @\add1 x
```

## Sym
Summarize a column of symbols.

```moonscript
class Sym extends Col
   new: (at,txt) =>
     super at,txt
     @all, @most, @mode = {}, 0, nil
   add1: (x) =>
     @all[x] = (@all[x] or 0) + 1
     @most,@mode = @all[x],x if @all[x] > @most
   ent: =>
     e=0
     for _,v in pairs @all do e -= v/@n*math.log(v/@n)/math.log(2)
     e
   mid: => @mode
   spread: => @\ent!
```

## Num
Summarize numeric columns

```moonscript
class Num extends Col
  new: (at,txt) =>
    super at,txt
    @mu,@sd,@m2,@lo,@hi = 0,0,0,1E32,-1E32
  add1: (x) =>
    d    = x - @mu
    @mu += d/@n
    @m2 += d*(x-@mu)
    @sd  = (@n<2 and 0 or (@m2<0 and 0 or @m2/(@n-1)))^0.5
    @lo  = x if x < @lo
    @hi  = x if x > @hi
```

## Exports
Just the stuff anyone else might need.

```moonscript
:Col, :Sym,  :Num
```
