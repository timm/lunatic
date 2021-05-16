#!/usr/bin/env moon
-- vim: ts=2 sw=2 et :

require "fun"
import Data,Cols from require "data"
import Sym,Num   from require "col"

eg={}

eg.sym = ->
  s=Sym!
  s\adds {"a", "a", "a", "a", "b", "b", "c"}
  assert 4==s.all.a
  print s\ent()

eg.cols = ->
  x = Cols {"A?", "B","C-"}
  assert #x.ys == 1
  assert x.ys[1].w == -1
  assert #x.xs == 1
  assert #x.all == 3

eg.data = ->
  t=Data!
  [t\add(x) for x in csv "../etc/data/auto93.csv"]
  print("data",t.rows[#t.rows][1])
  print(t.cols.all)
  
cli= (all) ->
  walk = (x) -> print("-- "..x) or all[x]()
  a = sorted [x for x,_ in pairs all]
  if s = arg[1]
    if s=="?" then [print(" - #{x}") for x in *a]
    if all[s] then walk(s) 
  else
    [walk(s) for s in *a]

cli eg
