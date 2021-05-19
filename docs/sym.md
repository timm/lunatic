---
title: "sym.moon"
---


Summarize a column of symbols.

```moonscript
import sum,cat,fmt,sorted from require "fun"
import Col from require "col"
```

## basics

```moonscript
class Sym extends Col
   new: (at,txt) =>
     super at,txt
     @all, @most, @mode = {}, 0, nil
   add1: (x,n=1) =>
     @all[x] = (@all[x] or 0) + n
     @most,@mode = @all[x],x if @all[x] > @most
```

## reporting 

```moonscript
   mid:    => @mode
   spread: => @\ent!
   ent:    => 
     sum [-v/@n*math.log(v/@n)/math.log(2) for _,v in pairs @all]
   report: (w=20,r=1) =>
     how="%#{w}s : %s (%s)"
     fmt(how, @txt, cat(sorted[k for k,_ in pairs @all]),@mode)
```

## distance 

```moonscript
   norm1: (x)  => x
   dist1: (x,y) => x==y and 0 or 1
```

This is [Aha's distance calculation](refs#Aha91) for symbols. 
## bayes

```moonscript
   like: (x,prior,my) => ((@seen[x] or 0)+prior*my.m) / (@n+my.m)
```

Suppose `x` has been `seen` so many times within a population of `@n` samples,
In that case, `x` is "liked" at probability `seen/@n`.
Also,  in one special case, we have to do a little more:
- To handle low frequency observations,
[Yang](refs#Yang02) (in section three) advocate a `k` kludge (typically, `k`=1)
which combines the `prior` probability with   the `k` fudge factor .
- Note that as `seen` and/or `@n` gets large then
this kludge has a vanishingly small effect.
## discretization

```moonscript
   simpler: (j) =>
     k= @\merge(j)
     e1,n1 = @\ent!, @n
     e2,n2 = j\ent!, j.n
     e, n  = k\ent!, k.n
     return k if e1+e2 < 0.01 or e *.95 < (n1*e1 + n2*e2)/n
   merge: (j) =>
     k = Sym(@at, @txt)
     for seen in *{@seen, j.seen}
       for x,n in pairs seen 
         k\add x,n
     k
```

## exports

```moonscript
:Sym
```
