#!/usr/bin/env moon
-- vim: ts=2 sw=2 et :

package.moonpath = '../src/?.moon;' .. package.moonpath
import cli from require "fun"
import Sym from require "sym"

eg={}
eg.sym = ->
  s=Sym!
  s\adds {"a", "a", "a", "a", "b", "b", "c"}
  assert 4==s.all.a
  e = s\ent()
  print(e)
  assert 1.378  <= e and  e <=1.38, "bad ent"

cli eg
