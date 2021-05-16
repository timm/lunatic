---
title: "eg.moon"
---

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
run= (s) ->
  walk= (x) -> print("-- "..x) or eg[x]()
  egs = sorted [x for x,_ in pairs eg]
  if not s  then return [walk(s) for s in *egs]
  if s=="?" then [print("./eg.moon #{x}") for x in *egs]
  if eg[s]  then walk(s) else print("W> unknown: '#{s}'")
run arg[1]
```
