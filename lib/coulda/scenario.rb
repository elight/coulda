class Scenario
  attr_reader :name

  def initialize(name, &block)
    @name = name.to_s
    @conditions = []
    @pending = true
  end

  %w[given when then].each do |condition|
    define_method condition do |name, block|
      #@conditions = {:name => name, :impl => block} 
      #block.call
    end
  end

  def pending?
    @pending
  end

  def method_missing(name, *args)
    if %w[given when then].include? name
    else
      raise NoMethodError.new(name.to_s)
    end
  end


end
