---
title: "about.moon"
---


Configuration  options
which,  optionally, can be tweaked from the  command-line.

```moonscript
import Rand, sorted from require "fun"
class About
  @what      = "./lunatic.moon [options]"
  @which     = "Data mining, optimizers, via constrast set learning"
  @version   = 0.2
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
  new: => 
    @all = {k,v[1] for k,v in pairs @@default}
  showHelp: (a, width1=10,width2=15) =>
    help = (k,d,h) ->
      s1,s2 = " "\rep(width1-#k), " "\rep(width2-#tostring(d))
      print "  -#{k}#{s1} #{d}#{s2} #{h}"
    print "\n#{@@what}\n#{@@which}"
    print "version #{@@version}, #{@@copyright}\n\nOptions:"
    help "h","","show help"
    for k in *sorted [k for k,_ in pairs a]
      help k,a[k][1],a[k][2]
  update: (arg,      i=0)=>
    while i < #arg
      i   += 1
      flag = arg[i]\gsub("^-","")
      if @all[flag]
        i += 1
        @all[flag] = tonumber(arg[i+1]) or arg[i+1] 
      elseif flag=="h" @\showHelp @@default
      else             print "?? '#{flag}' unknown"
    @all
```

--------------------------

```moonscript
About!\update arg
```
