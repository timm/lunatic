# it.moon 
moon=require("moon")
p=moon.p
f = =>
  _f = (last) => if last==@ then return else last+1
  _f, @, 0
print x for x in f 10
csv = (f) ->
  stream = io.input(f)
  =>
    if s = io.read()
      [tonumber(x) or x for x in s\gsub("([\t\r ]*|--.*)","")\gmatch("([^,]+)")]
    else
      io.close(stream) and nil
print(#x) for x in csv "it.moon"  when #x>0
23,18,20,11,22 --asdas
```
