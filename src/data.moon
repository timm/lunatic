#!/usr/bin/env moon
-- vim: ts=2 sw=2 et :

-- Tools for storing rows of data, summarized into columns.
require "fun"
import Col, Num, Sym from require("col")

-- ## Skip
-- Anything sent to `Skip` just gets ignored.
class Skip extends Col
  new: (at,txt) =>
    super at,txt
    @_xx = 22
  add1: (x) => x

-- ## Cols
-- Manager for columns. Creates the right kind of columns, 
-- stores them in different kinds of arrays.
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

-- ## Data
-- Stores data in `rows`, and summarizes that data in  `Col`umns.
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

-- ## Exports
-- Just the stuff anyone else might need.
:Data
