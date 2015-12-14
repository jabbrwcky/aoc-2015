#!/usr/bin/env ruby
require 'digest'

SECRET='yzbqklnj'

COND=/^0{5}.+/
n = 0
hash=''
until COND.match(hash)
  n+=1
  hash = Digest::MD5.hexdigest "#{SECRET}#{n}"
end
puts hash, n
