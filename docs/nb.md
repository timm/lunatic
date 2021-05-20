---
title: "nb.moon"
---


Naive Bayes  classifier

```moonscript
import Data from require "data"
nbs = (file) ->
class Nb
  new: () => @ready, @all, @some = false, Data!, {}
  add: (a) =>
    return if #a==0
    @all\add a
    if @ready
    @ready = true
```

## exports

```moonscript
:nb
```
