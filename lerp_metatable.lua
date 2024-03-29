local lerp = {}
lerp.__index = lerp

lerp.cache = {}

---@param Name string
---@param StartValue number
lerp.new = function(Name)
    lerp.cache[Name] = 0;
end

---@param Name string
---@param LerpTo number
---@param Speed number
lerp.lerp = function(Name, LerpTo, Speed)
    if lerp.cache[Name] == nil then
        lerp.new(Name);
    end

    lerp.cache[Name] = lerp.cache[Name] + (LerpTo - lerp.cache[Name]) * (globals.frametime * Speed);

    return setmetatable({name = Name}, lerp);
end;

---@param LerpTo number
---@param Speed number
function lerp:update(LerpTo, Speed)
    self.cache[self.name] = self.cache[self.name] + (LerpTo - self.cache[self.name]) * (globals.frametime * Speed);
    return self.cache[self.name];
end

function lerp:get()
    return self.cache[self.name];
end

function lerp:reset()
    self.cache[self.name] = 0;
    return true;
end

function lerp:delete()
    self.cache[self.name] = nil;
    return true;
end

return lerp
