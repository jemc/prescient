

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
    
    def initialize
      @facts = {}
      yield self if block_given?
    end
    
    # Create a class-level fact - applies to all instances of the class
    def self.fact(sym, &block)
      @facts ||= {}
      @facts[sym] = (block or instance_method(sym))
    end
    
    # Create an instance-level fact - applies only to the instance
    def fact(sym, &block)
      @facts[sym] = (block or method(sym))
    end
    
    # Return the hash of callable fact objects
    def facts
      # bind class-wide facts and merge with instance-wide facts
      Hash[(self.class.instance_variable_get(:@facts) or {}).map do |k,v|
        v = v.bind(self) rescue NoMethodError
        [k, v]
      end].merge(@facts)
    end
    
  end
  
end

