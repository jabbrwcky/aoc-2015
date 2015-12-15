#!/usr/bin/env ruby
require 'digest'

SECRET='yzbqklnj'

def nmbr(count)
  cond=Regexp.new("^0{#{count}}.+")
  n = 0
  hash=''
  until cond.match(hash)
    n+=1
    hash = Digest::MD5.hexdigest "#{SECRET}#{n}"
  end
  n
end

puts nmbr(5)
puts nmbr(6)
