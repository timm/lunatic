#!/usr/bin/env moon
-- vim: ts=2 sw=2 et :

package.moonpath = '../src/?.moon;' .. package.moonpath
import said,csv,cli,eg from require "fun"
import Cols,Data       from require "data"

eg={}
eg.cols = ->
  x = Cols {"A?", "B","C-"}
  assert #x.ys == 1
  assert x.ys[1].w == -1
  assert #x.xs == 1
  assert #x.all == 3

eg.data = ->
  t=Data!
  [t\add x for x in csv "../etc/data/auto93.csv"]
  [said c for c in *t.cols.ys]
  assert 398 == #t.rows

cli eg
