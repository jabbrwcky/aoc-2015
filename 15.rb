#!/usr/bin/env ruby
require 'yaml'

MAX_TSP = 100

class IngredientsSolver
  def initialize(ingredients, factors)
    @ingredients = ingredients

    @num_ingredients = @ingredients.keys
    @factors = factors

    @partial_solutions = @ingredients.keys.map do |k|
      val = @ingredients[k].values
      vl = []
      (0..100).each do |i|
        tp = val[0..@factors - 1].map { |a| a * i }
        vl << tp
      end
      [k, vl]
    end.to_h
  end

  def constraint?(composition)
    composition.values.reduce(:+) == TSP
  end

  def score(composition)
    composition.map { |k, v|
      @partial_solutions[k][v]
    }.inject(Array.new(@factors, 0)) { |memo, v|
      v.each_with_index { |e, i|
        memo[i] += e
      }; memo
    }.map{ |v|
      v<0 ? 0: v
    }.reduce(:*)
  end

  def solve
    initial_ratio = @ingredients.keys.map { |k| [k, MAX_TSP / @ingredients.keys.length] }
    [initial_ratio, score(initial_ratio)]
  end

  def candidate_combinations
    comb = []
    (1..MAX_TSP-(@num_ingredients-1)).each do |i_0|
      remaining = MAX_TSP - i_0
      current = comb << [i_0]
      (1..@num_ingredients-1).each do |i_n|
        (1..remaining - (@num_ingredients-i_n-1))
      end
    end
  end
end


puts IngredientsSolver.new(YAML.load(IO.read('15.yml')), 4).solve.inspect
