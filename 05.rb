#!/usr/bin/env ruby

list = IO.readlines('05-wordlist.txt').map(&:chomp)
c1 = list.reject{ |e| e == nil || e.strip.length == 0 }.reject{ |e| /.*?ab|cd|pq|xy.*?/ =~ e }
c2 = c1.reject{ |e| e.gsub(/[^aeiou]/, '').length<3 }
puts c2.count{ |e| /(.)\1/ =~ e }

puts list.select{ |e| /(..).*?\1/ =~ e }.count{ |e| /(.).\1/ =~ e}
