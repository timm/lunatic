#!/usr/bin/env moon
-- vim: ts=2 sw=2 et :

-- Configuration  options which,  optionally, can
-- be tweaked from the  command-line.
import Rand, sorted from require "fun"

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
-- -------------------------------------------------------
  new: =>
    @all = {k,v[1] for k,v in pairs @@default}
  showHelp: (width1=10,width2=15) =>
    t = @@default
    print "\n#{@@what}\n#{@@which}\n#{@@copyright}\n\nOptions:"
    for k,v in *sorted [k for k,_ in pairs t]
      d,h   = v[1], v[2]
      s1,s2 = " "\rep(width1-#k), " "\rep(width2-#tostring(d))
      print "  -#{k}#{s1} #{d}#{s2} #{h}"
  tweak: (      i=0)=>
    while i < #arg
      i   += 1
      flag = arg[i]\gsub("^-","")
      if @all[flag]
        i += 1
        @all[flag] = tonumber(arg[i]) or arg[i]
      elseif k=="h" @\showHelp! 
      else          print "?? '#{flag}' unknown"
    @all

--  --------------------------
Options!\tweak!
