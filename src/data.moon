#!/usr/bin/env moon
-- vim: ts=2 sw=2 et :

-- Tools for storing rows of data, summarized into columns.

--  Requires:
require "fun"
is=require "is"
import Col, Num, Sym from require "col"

-- ## Skip
-- Anything sent to `Skip` just gets ignored.
class Skip extends Col
  add1: (x) => x

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
      if is.y     txt then @ys[#@ys + 1] = col
      if is.x     txt then @xs[#@xs + 1] = col
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

-- ## Exports
-- Just the stuff anyone else might need.
:Data, :Cols
