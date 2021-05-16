#!/usr/bin/env moon
-- vim: ts=2 sw=2 et :

-- Data header utils
is={}

is.weighted= (s)-> if s\find"-" then -1  else 1
is.klass   = (s)-> s\find"!"
is.skip    = (s)-> s\find"?"
is.num     = (s)-> s\match"^[A-Z]"
is.y       = (s)-> s\find"+" or s\find"-" or is.klass s

-- Returns...
is
