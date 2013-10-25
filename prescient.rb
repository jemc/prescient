

module Prescient
  
  class Studier
    
    def study(events)
      for event in events
        for name, fact in event.facts
          p [name, fact.call]
        end
      end
    end
    
  end
  
  
  class Event
    
    attr_reader :facts
    
    def initialize
      @facts = {}
      yield self if block_given?
    end
    
    def fact(sym, &block)
      raise ArgumentError, "sym argument can't be nil" if sym.nil?
      @facts[sym] = (block or method(sym))
    end
    
  end
  
end

