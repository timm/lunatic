#!/usr/bin/env moon
-- vim: ts=2 sw=2 et :

package.moonpath = '../src/?.moon;' .. package.moonpath
import cli from require "fun"
import Num from require "col"

eg={}
eg.num = ->
  n=Num!
  for i=1,10000
    n\adds {9,2, 5, 4, 12, 7, 8, 11, 9, 3,
              7, 4, 12, 5, 4, 10, 9, 6,9,4}
  print(n.sd,n.mu)

cli eg
