# proxyquire.lua
Allows Lua modules to be overridden during testing. See https://github.com/thlorenz/proxyquire.

## Example
```lua
local fake_module_1 = { ... }
local fake_module_2 = { ... }

local module_under_test = proxyquire('module_under_test', {
  module_1 = fake_module_1,
  module_2 = fake_module_2
})
```
