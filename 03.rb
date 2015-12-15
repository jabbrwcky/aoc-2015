#!/usr/bin/env ruby

input = IO.read('03-input').chomp

def just_santa(input)
  h = Hash.new{ |hash,key| hash[key]=Hash.new{|h,k| h[k]=0 }}
  h[0][0] = 1

  x = 0
  y = 0
  steps = 0

  input.each_char do |c|
    skip = false
    case c
    when '^'
      y += 1
    when '<'
      x -= 1
    when '>'
      x += 1
    when 'v'
      y -= 1
    else
      skip = true
    end

    unless skip
      steps += 1
      h[x][y] += 1
      puts "#{steps} #{c}: (#{x},#{y}) [#{h[x][y]}]"
    end
  end

  sum = 0
  h.values.each do |col|
    sum += col.values.count{ |p| p>0 }
  end
  sum
end

def robo_santa(input)
  h = Hash.new{ |hash,key| hash[key]=Hash.new{|h,k| h[k]=0 }}
  h[0][0] = 1

  x = 0
  y = 0
  steps = 0

  ic = input.chars
  while st = ic.shift(2) do
    st[]
  end
end


puts just_santa(input)
