#!/usr/bin/env ruby

class LightArray

  INSTRUCTION = /^(?<instr>turn o(n|ff)|toggle) (?<X0>\d{1,3}),(?<Y0>\d{1,3}) through (?<X1>\d{1,3}),(?<Y1>\d{1,3})$/

  def initialize(x,y)
    @lights=Array.new(x){ |i| Array.new(y,0)}
    @brightness=Array.new(x){ |i| Array.new(y,0)}
  end

  def parse(line)
    mr = INSTRUCTION.match(line)
    [ mr['instr'].to_sym, mr['X0'].to_i, mr['Y0'].to_i, mr['X1'].to_i, mr['Y1'].to_i]
  end

  def execute_step(command, x0, y0, x1, y1)
    (x0..x1).each do |x|
      (y0..y1).each do |y|
        case command
        when :'turn off'
          @lights[x][y]=0
          bn=@brightness[x][y] - 1
          @brightness[x][y]=(bn < 0 ? 0 : bn)
        when :'turn on'
          @lights[x][y]=1
          @brightness[x][y]+=1
        when :toggle
          old = @lights[x][y]
          @lights[x][y] = (old-1).abs
          @brightness[x][y]+=2
        end
      end
    end
  end

  def light_it_up
    IO.readlines("06-input.txt").each { |i| execute_step(*parse(i)) }
    on= @lights.reduce(0){ |memo,e| memo + e.reduce(:+) }
    off= @lights.reduce(0){ |memo,e| memo + e.count{ |l| l == 0 } }
    total_brightness= @brightness.reduce(0){ |memo,e| memo + e.reduce(:+) }
    puts "ON: #{on}, OFF: #{off} (#{on+off}) Total brightness: #{total_brightness}"
  end
end

LightArray.new(1000,1000).light_it_up
