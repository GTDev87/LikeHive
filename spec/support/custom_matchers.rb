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
  
  class ReturnResultsNameArray
    def initialize(expected)
      @expected = expected
    end
    def matches?(target)
      @target = Array.new
      target.each do |result|
        @target << result.name
      end
      if @target.size != @expected.size
        return false
      end
      @expected.zip(@target).each do |expect, actual|
        if expect != actual
          return false
        end
      end
      return true
    end
    def failure_message
      "expected names #{@target.inspect} to but found nameds #{@expected}"
    end
    def negative_failure_message
      "expected names #{@target.inspect} not to be the same as #{@expected}"
    end
  end

  def return_results_name_array(expected)
    ReturnResultsNameArray.new(expected)
  end
  
  class ContainResultFirstNamed
    def initialize(expected)
      @expected = expected
    end
    def matches?(target)
      @target = target
      @target.each do |result|
        if result.profile.name.first == @expected
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

  def contain_result_with_first_name(expected)
    ContainResultFirstNamed.new(expected)
  end
end

RSpec.configure do |config|
  config.include CustomMatchers
end