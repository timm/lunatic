#!/usr/bin/env moon
-- vim: ts=2 sw=2 et :
package.moonpath = '../src/?.moon;' .. package.moonpath
require "fun"
eg={}

import Sym,Num from require "col"


eg.sym = ->
  s=Sym!
  s\adds {"a", "a", "a", "a", "b", "b", "c"}
  assert 4==s.all.a
  e = s\ent()
  print(e)
  assert 1.378  <= e and  e <=1.38, "bad ent"

eg.num = ->
  n=Num!
  for i=1,10000
    n\adds {9,2, 5, 4, 12, 7, 8, 11, 9, 3,
              7, 4, 12, 5, 4, 10, 9, 6,9,4}
  print(n.sd,n.mu)

cli eg
