module Coulda
  class Scenario
    attr_reader :name
    attr_accessor :statements

    def initialize(name, &block)
      @name = name.to_s
      @block = block
      @statements = []
      @pending = !block_given?
    end

    def pending?
      @pending
    end
  end
end
