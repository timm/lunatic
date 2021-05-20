#!/usr/bin/env moon
-- vim: ts=2 sw=2 et :

package.moonpath = '../src/?.moon;' .. package.moonpath
import cli from require "fun"
import Num from require "num"

eg={}
eg.num = ->
  n=Num!
  for i=1,1
    n\adds {9,2, 5, 4, 12, 7, 8, 11, 9, 3,
              7, 4, 12, 5, 4, 10, 9, 6,9,4}
  assert 3.06 < n.sd and n.sd < 3.061
  assert 7 == n.mu

cli eg
