#!/usr/bin/env moon
-- vim: ts=2 sw=2 et :

--  Storing data from one row

-- ## Rows
class Row
  new:(t)  => @cells = t

-- bayes stuff 
  like:(data, nall, dataall, my) =>
    prior = (#data.rows + my.k) / (nall + my.k * dataall)
    tmp   = math.log(prior)
    for col in data.cols.xs 
      v = @cells[col.at]
      if v != "?":
        tmp += math.log( col.like(v, prior, my) )
    tmp
 
-- distance stuff
  dist: (that,data,my, cols) =>
    d,n  = 0, 1E-31
    cols = cols or data.cols.xs
    for col in *cols
      tmp = col\dist  @cells[col.at], that.cells[col.at]
      d  += tmp^my.p
      n  += 1
    (d/n)^(1/my.p)

-- multi-objective stuff
  dominate:(that, data) =>
    s1, s2, e, n, = 0, 0, 2.718282, #data.cols.ys
    for col in *data.cols.ys
      a, b  = @cells[col.at], that.cells[col.at]
      a, b  = col.norm a, col.norm b
      s1   -= e^(col.w * (a - b) / n)
      s2   -= e^(col.w * (b - a) / n)
    return s1 / n < s2 / n

-- ## exports
:Data, :Cols
