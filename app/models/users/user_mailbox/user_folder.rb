class UserFolder
  attr_reader :container
  def initialize(messages)
    @container = UserMessageContainer.new(messages)
  end
end