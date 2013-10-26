
require_relative 'prescient'
include Prescient

require 'pry'

class Person < Datum
  
  attr_accessor :age
  facet :age
  
  facet def youth
    (100 - age) / 100.0
  end
  
  facet def anxiety
    @anxiety ||= Random.rand
  end
  
  facet def crankiness
    age / 100.0
  end
  
  facet def creaky_bones
    age >= 90
  end
  
end

class PersonCorrelator < Correlator
  
  def select_by(chosen_facet)
    @datums.select{ |d| d.get_facet(chosen_facet) }
  end
  
end

corr = PersonCorrelator.new.ingest(
1.upto(200).map do
  Person.new { |e|
    e.age = (Random.rand*100).to_i
  }
end.to_a)

p corr.select_by(:creaky_bones)
