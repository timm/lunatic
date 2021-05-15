local moon = require("moon")
local p = moon.p
local Col
do
  local _class_0
  local _base_0 = {
    adds = function(lst)
      if lst == nil then
        lst = { }
      end
      local _accum_0 = { }
      local _len_0 = 1
      for _index_0 = 1, #lst do
        local x = lst[_index_0]
        _accum_0[_len_0] = self:add(x)
        _len_0 = _len_0 + 1
      end
      return _accum_0
    end,
    add = function(x)
      if x ~= "?" then
        self.n = self.n + 1
        return self:add1(x)
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(s, at)
      if s == nil then
        s = ''
      end
      if at == nil then
        at = 0
      end
      self.n, self.at, self.txt = 1, at, s
    end,
    __base = _base_0,
    __name = "Col"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Col = _class_0
end
local Sym
do
  local _class_0
  local _parent_0 = Col
  local _base_0 = {
    add1 = function(x)
      self.all[x] = (self.all[x] or 0) + 1
      if self.all[x] > self.most then
        self.most, self.mode = self.all[x], x
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(s, at)
      _class_0.__parent.__init(self, s, at)
      self.all, self.most, self.mode = { }, 0, nil
    end,
    __base = _base_0,
    __name = "Sym",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Sym = _class_0
end
local x = Sym()
x:adds({
  "a",
  "a",
  "a",
  "?",
  "b",
  "b"
})
return print(x.all.a)
