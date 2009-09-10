class Scenario
  attr_reader :name

  def initialize(name, &block)
    @name = name
    @conditions = []
  end

  %w[given when then].each do |condition|
    define_method condition do |name, block|
      #@conditions = {:name => name, :impl => block} 
      #block.call
    end
  end
  def method_missing(name, *args)
    if %w[given when then].include? name
    else 
      raise NoMethodError.new(name)
    end
  end
end
