module Coulda
  class Scenario
    attr_reader :name

    Statement = Struct.new(:type, :name, :block)

    def initialize(name, &block)
      @name = name.to_s
      @block = block
      @statements = []
      @pending = !block_given?
    end

    %w[Given When Then].each do |statement|
      eval <<-HERE
        def #{statement}(name, &block)
          @statements << stmt = Statement.new(:#{statement}, name, block)
        end
      HERE
    end

    def pending?
      @pending
    end
  end
end
