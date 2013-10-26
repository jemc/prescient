
require_relative 'prescient'
include Prescient

require 'pry'

class Person < Datum
  
  attr_accessor :age
  facet :age
  
  facet def youth
    (100 - age) / 100.0
  end
  
end

Correlator.new.study [
  
  Person.new { |e|
    e.age = 52
  },
  
  Person.new { |e|
    e.age = 2
  }
  
]