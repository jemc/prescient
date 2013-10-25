
require_relative 'prescient'
include Prescient

require 'pry'

class MyEvent < Event
  fact def youth
    (100 - get_fact(:age)) / 100.0
  end
end

Studier.new.study [
  
  MyEvent.new { |e|
    e.fact(:age) { 52 }
  },
  
  MyEvent.new { |e|
    e.fact(:age) { 2 }
  },
  
  Event.new { |e|
    e.fact(:age) { 23 }
  }
  
]