require 'spec_helper'

describe UserMessageContainer do  
  describe "accepting visitors" do
    
    class MockMessageVisitor
      attr_reader :messages
  
      def initialize()
        @messages = []
      end
  
      def visit_message(message)
        messages << message
      end
    end
    
    it "should accept visitors which iterate through message collection" do
      messages = []
      5.times do
        messages << Factory.build(:connection_message)
      end
      user_message_container = UserMessageContainer.new(messages)
      mock_visitor = MockMessageVisitor.new()
      
      user_message_container.accept_message_visitor(mock_visitor)
      
      mock_visitor.messages.should =~ messages
    end
  end
end