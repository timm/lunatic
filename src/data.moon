#!/usr/bin/env moon
-- vim: ts=2 sw=2 et :

--  Storing data in rows, summarized in columns.
import sorted from require "fun"
import is     from require "is"
import Num    from require "Num"
import Sym    from require "Sym"
import Skip   from require "Col"

-- ## Cols
-- Manager for columns. Creates the right kind of columns, 
-- stores them in different kinds of arrays.
class Cols
  new:(t)  =>
    @all, @xs,  @ys, @klass = {},{},{},nil
    for at,txt in pairs t do @\new1 at,txt
  new1: (at,txt) =>
    what = txt\find"?" and Skip or (is.num(txt) and Num or Sym)
    col  = what(at,txt)
    @all[#@all + 1] = col
    if col.__class != Skip
      if is.klass txt then @klass = col
      where = is.y(txt) and @ys or @xs
      where[#where + 1] = col
  summarize: (a) => [col\add a[col.at] for col in *@all]

-- ## Data
-- Stores data in `rows`, and summarizes that data in  `Col`umns.
class Data
  new:(a={}) =>
    @rows, @cols = {}, nil
    for x in *a do @\add x
  add: (a) =>
    return if #a==0
    if @cols then
      @cols\summarize a
      @rows[#@rows+1]= a
    else @cols = Cols a
  clone:(a={}) =>
    out = Data [col.txt for col in *@cols.all]
    [out\add x for x in *a]
    out

-- ## exports
:Data, :Cols
