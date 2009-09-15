module Coulda
  class Scenario
    attr_reader :name

    Statement = Struct.new(:type, :name, :block)

    def initialize(name, &block)
      @name = name.to_s
      @block = block
      @statements = []
      check_statements
      @pending = @statements.empty? || @statements.any? { |s| s.block.nil? }
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

    private

    def check_statements
      if @block
        instance_eval &@block
        assert_statements
      end
    end

    def assert_statements
      if !pending? && @statements
        assert_presence_of_statements
        assert_order_of_statements
      end
    end

    def assert_presence_of_statements
      givens_present = @statements.any? { |s| s.type == :Given }
      raise SyntaxError.new("No Givens are present") unless givens_present
      whens_present = @statements.any? { |s| s.type == :When }
      raise SyntaxError.new("No Whens are present") unless whens_present
      thens_present = @statements.any? { |s| s.type == :Then }
      raise SyntaxError.new("No Thens are present") unless thens_present
    end

    def assert_order_of_statements
      stmt_types = @statements.collect { |s| s.type }
      unless stmt_types.rindex(:Given) < stmt_types.index(:When) && 
             stmt_types.rindex(:When) < stmt_types.index(:Then)
        raise SyntaxError.new("Given, Whens, Thens are out of order")
      end
    end
  end
end
