#!/usr/bin/env moon
-- vim: ts=2 sw=2 et :

moon=require "moon"
col=require "col"
lib=require "liblua"

eg={}
eg.all= -> [f() for k,f in pairs eg when k!="all"]

eg.sym = ->
  s=col.Sym!
  s\adds {"a", "a", "a", "a", "b", "b", "c"}
  assert 4==s.all.a
  print s\ent()

eg.cols = ->
  it = col.Cols {"A?", "B","C-"}
  assert #it.ys == 1
  assert it.ys[1].w == -1
  assert #it.xs == 1
  assert #it.all == 3

eg.data = ->
  t=col.Data!
  for x in col.csv("../etc/data/auto93.csv")
    t\add x
  lib.oo(t.rows[1])
  
--egs.all()
eg.data()
