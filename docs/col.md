---
title: "col.moon"
---


Tools for storing data.

```moonscript
require "fun"
```

## Col
Generic stuff for all columns.

```moonscript
class Col
  new: (at=1,txt='') => 
    @n, @at, @txt, @w = 1, at, txt, weight(txt)
  adds: (a) => [@\add(x) for x in *a]
  add:  (x) =>
   if x != "?" 
     @n += 1
     @\add1 x
```

## `Sym`bols summarize a column of symbols.

```moonscript
class Sym extends Col
  __tostring: => show(@)
   new: (at,txt) =>
     super at,txt
     @all, @most, @mode = {}, 0, nil
   add1: (x) =>
     @all[x] = (@all[x] or 0) + 1
     @most,@mode = @all[x],x if @all[x] > @most
   ent: (    e=0) =>
     for _,v in pairs @all do e -= v/@n*math.log v/@n,2
     e
   mid: => @mode
   spread: => @\ent!
```

## Skip
Anything sent to `Skip` just gets ignored.

```moonscript
class Skip extends Col
  add1: (x) => x
```

## Num
Summarize numeric columns

```moonscript
class Num extends Col
  __tostring: => show(@)
  new: (at,txt) =>
    @mu,@sd,@m2,@lo,@hi = 0,0,0,1E32,-1E32
    @all = {}
    super at,txt
  add1: (x) =>
    d    = x - @mu
    @mu += d/@n
    @m2 += d*(x-@mu)
    @sd  = (@n<2 and 0 or (@m2<0 and 0 or @m2/@n))^0.5
    @lo  = x if x < @lo
    @hi  = x if x > @hi
```

## Cols
Manager for columns. Creates the right kind of columns, 
stores them in different kinds of arrays.

```moonscript
class Cols
  __tostring: => show(@)
  new:(t)  =>
    @xs,  @ys, @all, @klass = {},{},{},nil
    for at,txt in pairs t do @\new1 at,txt
  new1: (at,txt) =>
    what = txt\find"?" and Skip or (isNum(txt) and Num or Sym)
    x    = what at,txt
    @all[#@all + 1] = x
    if x.__class != Skip
      if isKlass txt then @klass = x
      if isY     txt then @ys[#@ys + 1] = x
      if isX     txt then @xs[#@xs + 1] = x
    x
  add: (a) => 
   for col in *@all do col\add a[col.at]
   a
```

## Data
Stores data in `rows`, and summarizes that data in  `Col`umns.

```moonscript
class Data
  __tostring: => show(@)
  new:(a={}) =>
    @rows, @cols = {}, nil
    for x in *a do @\add x
  add: (x) => 
    return if #x==0
    if @cols then @rows[#@rows+1]=@cols\add x else @cols= Cols x
  clone:(a={}) =>
    out = Rows [col.txt for col in *@cols.all] 
    for x in *a do out\add x
    out
```

## Exports
Just the stuff anyone else might need.

```moonscript
:Data, :Sym,  :Num
```
