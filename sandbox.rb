
require_relative 'prescient'
include Prescient

require 'pry'


Studier.new.study [
  
  Event.new { |e|
    e.fact(:age) { 52 }
  }
  
]