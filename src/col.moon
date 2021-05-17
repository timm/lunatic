#!/usr/bin/env moon
-- vim: ts=2 sw=2 et :

-- Tools for summarizing data.
require "fun"
is=require "is"

-- ## Col
-- Generic stuff for all columns.
class Col
  new: (at=1,txt='') => 
    @at, @txt, @w = at, txt, is.weighted(txt)
    @n, @rank = 0, 0
  adds: (a) => [@\add(x) for x in *a]
  add:  (x,n=1) =>
    if x != "?" 
      @n += n
      @\add1 x,n
  norm: (x)   =>  x=="?" and x or @\norm1 x
  dist: (x,y) =>  (x=="?" and y=="?") and  1 or @\dist1(x,y)

-- ## Skip
-- Anything sent to `Skip` just gets ignored.
class Skip extends Col
  add1: (x,_) => x

-- ## Exports
:Col :Skip
