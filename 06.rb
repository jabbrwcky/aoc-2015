#!/usr/bin/env ruby

class LightArray

  INSTRUCTION = /^(?<instr>turn o(n|ff)|toggle) (?<X0>\d{1,3}),(?<Y0>\d{1,3}) through (?<X1>\d{1,3}),(?<Y1>\d{1,3})$/

  def initialize(x,y)
    @lights= Array.new(x,Array.new(y,0))
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
        when :'turn on'
          @lights[x][y]=0
        when :toggle
          old = @lights[x][y]
          @lights[x][y] = (@lights[x][y]-1).abs
        else
          puts "Unknown instruction: #{command}"
        end
      end
    end
  end

  def light_it_up
    IO.readlines("06-input.txt").each { |i| execute_step(*parse(i)) }
    i=0
    puts @lights.reduce(0){ |memo,e| l= e.reduce(:+); puts "#{i}:\t#{l}"; i+=1; memo + l }
  end

end

LightArray.new(1000,1000).light_it_up
