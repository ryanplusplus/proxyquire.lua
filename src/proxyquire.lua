return function(module, proxied_dependencies)
  local cache_copy = {}

  for k, v in pairs(proxied_dependencies) do
    cache_copy[k] = package.loaded[k]
    package.loaded[k] = v
  end

  local required = require(module)

  for k in pairs(proxied_dependencies) do
    package.loaded[k] = nil
  end

  for k, v in pairs(cache_copy) do
    package.loaded[k] = v
  end

  return required
end
