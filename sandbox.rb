
require_relative 'prescient'
include Prescient

require 'pry'


Studier.new.study [
  
  Event.new { |e|
    e.fact(:age) { 52 }
    e.fact(:youth) { (100 - e.facts[:age].call) / 100.0 }
  },
  
  Event.new { |e|
    e.fact(:age) { 52 }
    e.fact def e.youth
      (100 - facts[:age].call) / 100.0
    end
  }
  
]