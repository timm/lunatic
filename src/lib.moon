 -- vim: ts=2 sw=2 et :

--
lib  = require "liblua"
lines= lib.lines

cells= (s)-> [(tonumber(y) or y) for y in string.gmatch(s, "([^,]+)")]


:split, :lines

