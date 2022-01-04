# frozen_string_literal: true

require_relative "autotune/version"

module Autotune
  class Error < StandardError; end
  module_function
  def go_with(*list_of_arg_options, &block)
    leader_score= {}

    each_combination(*list_of_arg_options) do |*args|
      leader_score[*args] = time_taken{block.call(*args) }
    end

    leader_score.sort_by{|k,v| v}.first.first
  end

  def time_taken(&block)
    init = now
    block.call
    now - init
  end

  def now
    Process.clock_gettime(Process::CLOCK_MONOTONIC)
  end

  def each_combination(*list_of_arg_options)
    all =  list_of_arg_options
      .map{|options| to_array(options)}
    first = all.shift
    if all.empty?
      first.each {|i| yield i}
    else
      combs = (first).product(*all)
      combs.each {|i| yield i}
    end
  end
  def to_array(options)
    case options
    when Array then options
    when Range then range_to_array(options)
    else 
      raise "don't know how to handle #{options.inspect}"
    end
  end

  def range_to_array(range)
    if range.count < 10
      range.to_a
    else
      range.to_a.each_slice(range.count / 10).to_a.map(&:first) << range.last
    end
  end 
end


