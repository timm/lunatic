---
title: "data.moon"
---


Tools for storing rows of data, summarized into columns.

```moonscript
require "fun"
is=require "is"
import Col, Num, Sym from require "col"
```

## Skip
Anything sent to `Skip` just gets ignored.

```moonscript
class Skip extends Col
  add1: (x) => x
```

## Cols
Manager for columns. Creates the right kind of columns, 
stores them in different kinds of arrays.

```moonscript
class Cols
  new:(t)  =>
    @xs,  @ys, @all, @klass = {},{},{},nil
    for at,txt in pairs t do @\new1 at,txt
  new1: (at,txt) =>
    what = txt\find"?" and Skip or (is.num(txt) and Num or Sym)
    new  = what(at,txt)
    @all[#@all + 1] = new
    if new.__class != Skip
      if is.klass txt then @klass = new
      if is.y     txt then @ys[#@ys + 1] = new
      if is.x     txt then @xs[#@xs + 1] = new
  add: (a) => 
   for col in *@all do col\add a[col.at]
   a
```

## Data
Stores data in `rows`, and summarizes that data in  `Col`umns.

```moonscript
class Data
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
:Data, :Cols
```
