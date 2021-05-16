#!/usr/bin/env moon
-- vim: ts=2 sw=2 et :

-- Tools for summarizing data.
require "fun"

-- ## Col
-- Generic stuff for all columns.
class Col
  new: (at=1,txt='') => 
    @n, @at, @txt, @w = 1, at, txt, weight(txt)
  adds: (a) => [@\add(x) for x in *a]
  add:  (x) =>
   if x != "?" 
     @n += 1
     @\add1 x

-- ## `Sym`bols summarize a column of symbols.
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

-- ## Num
-- Summarize numeric columns
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

-- ## Exports
-- Just the stuff anyone else might need.
:Col, :Sym,  :Num
