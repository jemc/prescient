

module Prescient
  
  class Studier
    
    def initialize
      @fact_weights = {}
    end
    
    def study(events)
      # Pull in fact names from each event
      events.each{ |e| e.facts.each{ |sym,_| @fact_weights[sym] ||= 0.0 } }

      p @fact_weights
    end
    
  end
  
  
  class Event
    
    def initialize
      @facts = {}
      @cached_facts = {}
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
    
    # Return the result value of a specific fact
    def get_fact(sym, use_cache:false)
      (use_cache and @cached_facts[sym]) or \
        (@cached_facts[sym] = facts[sym].call)
    end
  end
  
end

