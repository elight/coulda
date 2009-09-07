require 'coulda/feature'
require 'coulda/syntax_error'

module Kernel
  def feature(name, &block)
    f = Feature.for_name(name)
    f.class_eval(&block)
    f.assert_description
    f
  end
end
