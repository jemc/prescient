
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
  
  def theorize_about(chosen_facet)
    (@facet_weights.keys-[chosen_facet]).each do |f|
      data = select_by(chosen_facet).map{|d| d.get_facet(f)}
      p [f, data.max, data.min]
    end
  end
  
end

corr = PersonCorrelator.new.ingest(
1.upto(200).map do
  Person.new { |e|
    e.age = (Random.rand*100).to_i
  }
end.to_a)

p corr.theorize_about(:creaky_bones)
