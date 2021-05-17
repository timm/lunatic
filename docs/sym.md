---
title: "sym.moon"
---


Tools for summarizing data.

```moonscript
require "fun"
import Col from require "col"
```

Summarize a column of symbols.
## Basics

```moonscript
class Sym extends Col
   new: (at,txt) =>
     super at,txt
     @all, @most, @mode = {}, 0, nil
   add1: (x,n=1) =>
     @all[x] = (@all[x] or 0) + n
     @most,@mode = @all[x],x if @all[x] > @most
```

## Reporting 

```moonscript
   mid:    => @mode
   spread: => @\ent!
   ent:    =>
     sum [-v/@n*math.log(v/@n)/math.log(2) for _,v in pairs @all]
   summary:=>
     keys= table.concat(sorted [k for k,_  in pairs @all],", ")
     string.format("%20s : %s (%s)", @txt, keys, @mode)
```

## Distance 

```moonscript
   norm1: (x)  => x
   dist1: (x,y) => x==y and 0 or 1
```

## Bayes

```moonscript
   like: (x,prior,my) => ((@seen[x] or 0) + prior*my.m) / (@n + my.m)
```

## Discretization

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

## Exports

```moonscript
:Sym
```