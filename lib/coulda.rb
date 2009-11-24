module Coulda
  SyntaxError = Class.new(StandardError)
end

require 'test/unit'

gem 'pending', '>= 0.1.1'
require 'pending'

require 'coulda/feature'
require 'coulda/scenario'
require 'coulda/vendor/constantize'
require 'coulda/vendor/underscore'

module Kernel
  def Feature(name, opts = {}, &block)
    f = Feature.new(name, opts)
    f.instance_eval &block if block_given?
    f.assert_presence_of_intent
    f
  end
end

