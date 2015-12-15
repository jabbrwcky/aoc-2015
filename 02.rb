#!/usr/bin/env ruby

dimensions = IO.readlines('02-input.txt').map(&:chomp).map{|d| d.split('x').map(&:to_i)}

def surface(l, h, w)
  2 * l * w + 2 * w * h + 2 * h * l
end

def rwp(l,h,w)
  sides = []
  sides << l*w
  sides << w*h
  sides << h*l

  sum = 0
  sides.sort.zip([3,2,2]).map{|a| a[0]*a[1]}.each{|s| sum += s}
  sum
end

def ribbon(args)
  sides = args.sort
  (sides[0]*2 + sides[1]*2 ) + sides[0] * sides[1] * sides[2]
end

req_sqft = 0
req_ribbon = 0
dimensions.each do |p|
  req_sqft += rwp *p
  req_ribbon += ribbon p
end

puts "Required sq ft of wrapping paper: #{req_sqft} and #{req_ribbon} ft of ribbon"
