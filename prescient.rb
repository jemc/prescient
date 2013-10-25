

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
      # Initialize facts and gather class facts into instance facts
      @facts = {}
      self.class.facts.each_pair do |sym, fact|
        @facts[sym] = fact.bind(self) rescue NoMethodError
      end if self.class.facts
      
      # Run the initialize block if given
      yield self if block_given?
    end
    
    # Create an instance-level fact - applies only to the instance
    def fact(sym, &block)
      raise ArgumentError, "sym argument can't be nil" if sym.nil?
      @facts[sym] = (block or method(sym))
    end
    attr_reader :facts
    
    # Create a class-level fact - applies to all future instances of the class
    def self.fact(sym, &block)
      raise ArgumentError, "sym argument can't be nil" if sym.nil?
      @facts ||= {}
      @facts[sym] = (block or instance_method(sym))
    end
    class << self; attr_reader :facts; end
    
  end
  
end

