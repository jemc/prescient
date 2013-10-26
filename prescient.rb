

module Prescient
  
  class Correlator
    
    attr_accessor :correlator
    
    def initialize
      @facet_weights = {}
    end
    
    def study(events)
      # Pull in facet names from each event
      events.each{ |e| e.facets.each{ |sym,_| @facet_weights[sym] ||= 0.0 } }
      
      1000.times do
        @facet_weights.keys.each do |k|
          @facet_weights[k] = Random.rand
        end
        
      end
    end
    
  end
  
  
  class Event
    
    def initialize
      @facets = {}
      @cached_facets = {}
      yield self if block_given?
    end
    
    # Create a class-level facet - applies to all instances of the class
    def self.facet(sym, &block)
      @facets ||= {}
      @facets[sym] = (block or instance_method(sym))
    end
    
    # Create an instance-level facet - applies only to the instance
    def facet(sym, &block)
      @facets[sym] = (block or method(sym))
    end
    
    # Return the hash of callable facet objects
    def facets
      # bind class-wide facets and merge with instance-wide facets
      Hash[(self.class.instance_variable_get(:@facets) or {}).map do |k,v|
        v = v.bind(self) rescue NoMethodError
        [k, v]
      end].merge(@facets)
    end
    
    # Return the result value of a specific facet
    def get_facet(sym, use_cache:false)
      (use_cache and @cached_facets[sym]) or \
        (@cached_facets[sym] = facets[sym].call)
    end
  end
  
end

