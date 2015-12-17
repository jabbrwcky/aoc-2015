#!/usr/bin/env ruby

class Reindeer
  attr_reader :total_distance, :total_time, :name, :racing
  attr_accessor :score

  def initialize (name, speed, endurance, rest)
    @name= name
    @speed = speed
    @endurance = endurance
    @rest = rest
    @moving=0
    @resting=0
    @total_distance=0
    @score=0
    @total_time=0
    @racing=true
  end

  #Advance 1 sec
  def race()
    @total_time += 1

    if (@racing)
      @moving += 1
      @total_distance += @speed
      if @moving == @endurance
        @racing = false
        @moving = 0
      end
    else
      @resting += 1
      if @resting == @rest
        @racing = true
        @resting = 0
      end
    end
  end

  def <=>(other)
    return 1 if @total_distance > other.total_distance
    return 0 if @total_distance == other.total_distance
    -1
  end

  def to_s
    "#{name}: #{total_distance} km (#{@resting ? 'rests' : 'races'})"
  end
end

RACE_TIME=2503 #seconds

# Vixen can fly 8 km/s for 8 seconds, but then must rest for 53 seconds.
# Blitzen can fly 13 km/s for 4 seconds, but then must rest for 49 seconds.
# Rudolph can fly 20 km/s for 7 seconds, but then must rest for 132 seconds.
# Cupid can fly 12 km/s for 4 seconds, but then must rest for 43 seconds.
# Donner can fly 9 km/s for 5 seconds, but then must rest for 38 seconds.
# Dasher can fly 10 km/s for 4 seconds, but then must rest for 37 seconds.
# Comet can fly 3 km/s for 37 seconds, but then must rest for 76 seconds.
# Prancer can fly 9 km/s for 12 seconds, but then must rest for 97 seconds.
# Dancer can fly 37 km/s for 1 seconds, but then must rest for 36 seconds.

REINDEERS = [
  Reindeer.new('Vixen' ,8, 8, 53),
  Reindeer.new('Blitzen', 13, 4, 49),
  Reindeer.new('Rudolph', 20, 7, 132),
  Reindeer.new('Cupid', 12, 4, 43),
  Reindeer.new('Donner', 9, 5, 38),
  Reindeer.new('Dasher', 10, 4, 37),
  Reindeer.new('Comet', 3, 37, 76),
  Reindeer.new('Prancer', 9, 12, 97),
  Reindeer.new('Dancer', 37, 1, 36)
]

puts "0,#{REINDEERS.map(&:name).join(',')}"
for t in 1..RACE_TIME do
  REINDEERS.each{ |r| r.race }
  leader_distance = REINDEERS.map{ |r| r.total_distance }.max
  REINDEERS.each{ |r| r.score += 1 if r.total_distance == leader_distance }
  puts "#{t},#{REINDEERS.map{ |r| "#{r.total_distance} (#{r.racing ? '*' : ' ' })"}.join(',')}"
end

leader = REINDEERS.sort.reverse[0]
puts "Leader after #{RACE_TIME} seconds is: #{leader.name} with a distance of #{leader.total_distance}"
REINDEERS.sort_by{ |r| r.score }.reverse.each_with_index { |e, i| puts "#{i}: #{e.name} (#{e.score})"  }
