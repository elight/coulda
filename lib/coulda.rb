module Coulda
  SyntaxError = Class.new(StandardError)
end

require 'coulda/scenario'
require 'coulda/feature'


module Kernel
  def feature(name, &block)
    f = Feature.for_name(name)
    f.class_eval(&block)
    f.assert_description
    f
  end
end
