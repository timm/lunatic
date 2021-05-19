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

-- This is [Welford's incremental calculator](refs#Welford62) for computing standard
-- deviation and mean.  The current mean is wrong by some delta
-- `d` so, each time we see a number, we update `@mu` by that error amount.
-- But we acquire more information, and `@n` increases,
-- we trend towards ignoring that delta (see the `d/@n` calculation).
-- ## reporting 

  mid:               => @mu
  spread:            => @sd
  __tostring:(w=20,r=1) =>
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

-- This is Aha's distance calculation. If any number is unknown,
-- assume the worst and use the most distant possible value.
-- Also, to comparing numbers from different scales, first `norm`alize them
-- them to the same 0..1 range.
-- ## bayes

  like: (i,x,_) =>
    return 0 if x < @mu - 4*@sd 
    return 0 if x > @mu + 4*@sd 
    e     = 2.718282
    var   = @sd^2
    denom = (math.pi * 2 * var) ^ .5
    num   = e ^ (-(x - i.mu)^2 / (2 * var + 0.0001))
    num / (denom + 1E-64)

-- The closer `x` gets to the mean `@mu`, the more we believe it.
-- But if we are too far from the mean (more that four standard 
-- deviations) then we do not believe it at all.
-- ## exports
:Num
