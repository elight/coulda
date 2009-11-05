class Scenario
  attr_reader :name, :test_class
  attr_accessor :steps, :statements

  def initialize(name, my_feature, &block)
    @name = name
    @statements = []
    @steps = []
    @pending = false
    @test_class = Class.new(Test::Unit::TestCase)
    if block
      my_feature.current_scenario = self
      block.bind(my_feature).call
      class << @test_class
        attr_accessor :test_steps
      end
      @test_class.test_steps = @steps
      define_test_method { self.class.test_steps.each { |s| s.bind(my_feature).call } }
    else
      @pending = true
      define_test_method { pending }
    end
  end

  def pending?
    @pending
  end
  
  def define_test_method(&block)
    @test_class.send(:define_method, "test_#{@name.downcase.super_custom_underscore}", &block)
  end
end
