
require_relative 'prescient'
include Prescient

require 'pry'

class MyEvent < Event
  facet def youth
    (100 - get_facet(:age)) / 100.0
  end
end

Correlator.new.study [
  
  MyEvent.new { |e|
    e.facet(:age) { 52 }
  },
  
  MyEvent.new { |e|
    e.facet(:age) { 2 }
  },
  
  Event.new { |e|
    e.facet(:age) { 23 }
  }
  
]