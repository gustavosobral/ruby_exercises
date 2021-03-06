module ValidatePresenceOf
  class Matcher
    def initialize(attribute)
      @attribute = attribute
    end

    def matches?(model)
      @model = model
      @model.valid?
      @model.errors.has_key?(@attribute)
    end
    
    def failure_message
      "#{@model.class} failed to validate :#{@attribute} presence."
    end

    def negative_failure_message
      "#{@model.class} validated :#{@attribute} presence."
    end
  end

  def validate_presence_of (attribute)
    Matcher.new(attribute)
  end
end

RSpec.configure do |config|
  config.include ValidatePresenceOfName, type: :model
end

describe Zombie do
  it 'validates presence of name' do
    zombie = Zombie.new(name: nil)
    zombie.should validate_presence_of(:name)
  end
end
