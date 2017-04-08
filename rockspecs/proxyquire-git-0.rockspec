package = 'proxyquire'
version = 'git-0'
source = {
  url = 'https://github.com/ryanplusplus/proxyquire.lua/archive/master.zip',
  dir = 'proxyquire.lua-master/src'
}
description = {
  summary = 'Allows Lua modules to be overridden during testing. See https://github.com/thlorenz/proxyquire.',
  homepage = 'https://github.com/ryanplusplus/proxyquire.lua/',
  license = 'MIT <http://opensource.org/licenses/MIT>'
}
dependencies = {
  'lua >= 5.1'
}
build = {
  type = 'builtin',
  modules = {
    ['proxyquire'] = 'proxyquire.lua'
  }
}
