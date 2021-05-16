#!/usr/bin/env moon
-- vim: ts=2 sw=2 et :
package.moonpath = '../src/?.moon;' .. package.moonpath
require "fun"

import Sym,Num from require "col"

eg={}

eg.sym = ->
  s=Sym!
  s\adds {"a", "a", "a", "a", "b", "b", "c"}
  assert 4==s.all.a
  print s\ent()


cli eg
