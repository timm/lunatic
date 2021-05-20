#!/usr/bin/env moon
-- vim: ts=2 sw=2 et :

--  Naive Bayes  classifier
import Data from require "data"

nbs = (file) ->
  
class Nb
  new: () => @ready, @all, @some = false, Data!, {}
  add: (a) =>
    return if #a==0
    @all\add a
    if @ready
    @ready = true

-- ## exports
:nb
