

module Prescient
  
  class Studier
    
    def study(events)
      for event in events
        for fact in event.facts
          p fact.name
        end
      end
    end
    
  end
  
  
  class Event
    
    attr_reader :facts
    
    def initialize
      @facts = []
      yield self if block_given?
    end
    
    def fact(sym, &block)
      fact = block or method(sym)
      
      unless fact.respond_to? :name
        metafact = class << fact; self; end
        metafact.send(:define_method, :name) { sym }
      end
        
      @facts << fact unless @facts.include? fact
    end
    
  end
  
end

