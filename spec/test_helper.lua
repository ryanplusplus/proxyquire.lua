package.loaded.a = nil
package.loaded.b = nil

return {
  a = (require 'a'),
  b = (require 'b')
}
