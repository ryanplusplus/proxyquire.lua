--[[lit-meta
  name = 'ryanplusplus/proxyquire'
  version = '1.0.2'
  description = 'Allows Lua modules to be overridden during testing. See https://github.com/thlorenz/proxyquire.'
  tags = { 'testing' }
  license = 'MIT'
  author = { name = 'Ryan Hartlage' }
  homepage = 'https://github.com/ryanplusplus/proxyquire.lua'
]]

return function(module, proxied_dependencies)
  package.loaded[module] = nil

  local dependencies = {}
  local cache_copy = {}

  for module_name, overrides in pairs(proxied_dependencies) do
    cache_copy[module_name] = package.loaded[module_name]
    dependencies[module_name] = overrides
    if type(cache_copy[module_name]) == 'table' then
      for k, v in pairs(cache_copy[module_name]) do
        print(k, v)
      end
    end

    package.loaded[module_name] = nil
  end

  table.insert(package.searchers or package.loaders, 1, function(path)
    if dependencies[path] then
      return function()
        return dependencies[path] or cache_copy[path] -- union these
      end
    end
  end)

  local required = require(module)

  table.remove(package.searchers or package.loaders, 1)

  for k in pairs(proxied_dependencies) do
    package.loaded[k] = nil
  end

  for k, v in pairs(cache_copy) do
    package.loaded[k] = v
  end

  return required
end
