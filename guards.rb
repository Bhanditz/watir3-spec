module WatirSpec
  class Guard

    attr_accessor :type, :browsers, :data
  
    def initialize(type, browsers, data={})
      self.type, self.browsers, self.data = type, browsers, data
      WatirSpec.guards << self
    end
  
    def guarded?(browser)
      WatirSpec.guarded? || browsers.include?(browser.name)
    end
  
    module Helpers
      def deviates_on(*browsers)
        guard = WatirSpec::Guard.new :deviation, browsers, :file => caller.first
        yield unless guard.guarded?(OperaWatir::Waiter.browser)
      end

      def not_compliant_on(*browsers)
        guard = WatirSpec::Guard.new :non_compliance, browsers, :file => caller.first
        yield unless guard.guarded?(OperaWatir::Waiter.browser)
      end

      def compliant_on(*browsers)
        guard = WatirSpec::Guard.new :compliance, browsers, :file => caller.first
        yield unless guard.guarded?(OperaWatir::Waiter.browser)
      end

      def bug(url, *browsers)
        guard = WatirSpec::Guard.new :bug, browsers, :file => caller.first, :url => url
        yield unless guard.guarded?(OperaWatir::Waiter.browser)
      end
    end
    
  end
end
