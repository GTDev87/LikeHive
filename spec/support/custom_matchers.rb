module CustomMatchers
  class ContainResultNamed
    def initialize(expected)
      @expected = expected
    end
    def matches?(target)
      @target = target
      @target.each do |result|
        if result.name == @expected
          return true
        end
      end
      return false
    end
    def failure_message
      "expected #{@target.inspect} to contain result named #{@expected}"
    end
    def negative_failure_message
      "expected #{@target.inspect} not to contain result named #{@expected}"
    end
  end

  def contain_result_named(expected)
    ContainResultNamed.new(expected)
  end
end

RSpec.configure do |config|
  config.include CustomMatchers
end