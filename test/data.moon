#!/usr/bin/env moon
-- vim: ts=2 sw=2 et :
package.moonpath = '../src/?.moon;' .. package.moonpath
require "fun"
eg={}

import Cols,Data from require "data"

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

cli eg
