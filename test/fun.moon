#!/usr/bin/env moon
-- vim: ts=2 sw=2 et :
package.moonpath = '../src/?.moon;' .. package.moonpath
import Rand,sorted,said,csv,cli,eg from require "fun"
import Num from require "col"
import Cols from require "data"

eg={}

eg.rand= ->
  eqs=(a1,a2) ->
    for j,x in pairs a1 do return false if a2[j]!=x
    return true
  n = 10^4
  Rand.seed=1
  r=Rand!
  a1= sorted [r\any(10,20) for _=1,n]
  Rand.seed=1
  r=Rand!
  a2= sorted [r\any(10,20) for _=1,n]
  for i=1,10 do print(r\any())
  assert eqs(a1,a2)

eg.csv= ->
  a2=[a1 for a1 in csv "../etc/data/auto93.csv"]
  assert 399==#a2
  assert "number"==type(a2[#a2][1]) 

eg.say= ->
  c = Cols {"A?", "B","C-"}
  print #c.all
  print c.xs[1].txt
  said(c.all)
  said(true)
  said({1,2,3,4})

cli eg
