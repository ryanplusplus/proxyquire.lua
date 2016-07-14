return function(module, proxied_dependencies)
  local cache_copy = {}

  for k, v in pairs(proxied_dependencies) do
    cache_copy[k] = package.loaded[k]
  end

  table.insert(package.searchers or package.loaders, 1, function(path)
    if proxied_dependencies[path] then
      return function()
        return proxied_dependencies[path]
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