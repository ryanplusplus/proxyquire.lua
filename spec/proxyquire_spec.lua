describe('proxyquire', function()
  local proxyquire = require 'proxyquire'

  it('should inject specified depndencies', function()
    local expected = {
      a = {},
      b = {}
    }

    local actual = proxyquire('test_helper', { a = expected.a, b = expected. b })

    assert.are.equal(expected.a, actual.a)
    assert.are.equal(expected.b, actual.b)
  end)

  it('should replace proxied dependencies when finished', function()
    local b = {}

    package.loaded.a = nil
    package.loaded.b = b

    proxyquire('test_helper', { a = {}, b = {} })

    assert.is_nil(package.loaded.a)
    assert.are.equal(b, package.loaded.b)
  end)
end)
