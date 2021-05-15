---
title: "lib.moon"
---


--

```moonscript
lib  = require "liblua"
lines= lib.lines
cells= (s)-> [(tonumber(y) or y) for y in string.gmatch(s, "([^,]+)")]
:split, :lines
```
