#!/usr/bin/env moon
-- vim: ts=2 sw=2 et :

-- Summarize numeric columns
import fmt from require "fun"
import Col from require "col"

-- ## basics

class Num extends Col
  new: (at,txt) =>
    super at,txt
    @mu,@sd,@m2,@lo,@hi = 0,0,0,1E32,-1E32
  add1: (x,_) =>
    d    = x - @mu
    @mu += d/@n
    @m2 += d*(x-@mu)
    @sd  = (@n<2 and 0 or (@m2<0 and 0 or @m2/(@n-1)))^0.5
    @lo  = x if x < @lo
    @hi  = x if x > @hi

-- ## reporting 

  mid:               => @mu
  spread:            => @sd
  summary:(w=20,r=1) =>
    fmt("%#{w}s : %.#{r}f..%.#{r}f (%.#{r}f)",@txt,@lo,@hi,@mu)

-- ## distance 

  norm1: (x) => math.max(0,math.min(1,(x-@lo)/(@hi-@lo+1E-32)))
  dist1: (x,y) ->
    if x=="?"
      y= @\norm(y)
      x= y>.5 and 0 or 1
    elseif y=="?"
      x= @\norm(x)
      y= x>.5 and 0 or 1
    else
      x,y = @\norm(x), @\norm(y)
    math.abs x-y

-- ## bayes

  like: (i,x,_) =>
    return 0 if x < @mu - 4*@sd 
    return 0 if x > @mu + 4*@sd 
    e     = 2.718282
    var   = @sd^2
    denom = (math.pi * 2 * var) ^ .5
    num   = e ^ (-(x - i.mu)^2 / (2 * var + 0.0001))
    num / (denom + 1E-64)

-- ## exports
:Num
