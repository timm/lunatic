---
title: "lunatic.moon"
---


Config options

```moonscript
require "fun"
class Options
  @what      = "./lunatic.moon [options]"
  @which     = "Data mining, optimizers, via constrast set learning"
  @copyright = "(c) 2021 Tim Menzies, timm@ieee.org"
  @default   =
    dir:   {"../etc/data/", "where to find data"}
    data:  {"auto93.csv",   "data file"}
    k:     {1,              "kludge for low class frequencies"}
    m:     {2,              "kludge for low evidence frequencies"}
    seed:  {10013,          "random number seed"}
    cohen: {.35,            "defines small effects"}
    size:  {.5,             "min cluster size control"}
    some:  {1024,           "sub-sampling control"}
```

-------------------------------------------------------

```moonscript
  new: => @all = {k,v[1] for k,v in pairs @@default}
  showHelp: =>
    t = @@default
    print "\n#{@@what}\n#{@@which}\n#{@@copyright}\n\nOptions:"
    for k in *sorted [k for k,_ in pairs t]
      d,h   = t[k][1], t[k][2]
      s1,s2 = " "\rep(10-#k), " "\rep(15-#tostring(d))
      print "  -#{k}#{s1} #{d}#{s2} #{h}"
  cli: =>
    i=0
    while i < #arg
      i   += 1
      k    = arg[i]
      flag = k\gsub("^-","")
      if k=="-h"
        @\showHelp! if k=="-h"
      elseif @all[flag]
        @all[flag] = tonumber arg[i+1] or arg[i+1]
        i += 1
      else
        print "?? '#{flag}' unknown"
  run: =>
   @cli!
   Rand.seed = @all.seed
Options!\run!
```
