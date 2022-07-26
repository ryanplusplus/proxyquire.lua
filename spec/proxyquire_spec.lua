describe('proxyquire', function()
  local proxyquire = require 'proxyquire'

  it('should inject specified dependencies', function()
    local expected = {
      a = {},
      b = {}
    }

    local actual = proxyquire('test_helper', { a = expected.a, b = expected.b })

    -- assert.are.equal(expected.a, actual.a)
    assert.are.equal(expected.b, actual.b)
  end)

  it('should inject specified dependencies even when they are in package.loaded', function()
    package.loaded.a = 1
    package.loaded.b = 2

    local actual = proxyquire('test_helper', { a = 3, b = 4 })

    assert.are.equal(3, actual.a)
    assert.are.equal(4, actual.b)
  end)

  it('should pass through functionality that is not specified', function()
    package.loaded.a = {
      proxy_this = 1,
      not_proxied = 2
    }

    local actual = proxyquire('test_helper', { a = { proxy_this = 4 } })

    assert.are.equal(4, actual.a.proxy_this)
    assert.are.equal(2, actual.a.not_proxied)
  end)

  it('should do a deep merge', function()
    package.loaded.a = {
      something = {
        proxied = 5,
        not_proxied = 9
      },
      not_proxied = 2
    }

    local actual = proxyquire('test_helper', { a = { proxy_this = 4 } })

    assert.are.equal(5, actual.a.something.proxied)
    assert.are.equal(2, actual.a.something.not_proxied)
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
