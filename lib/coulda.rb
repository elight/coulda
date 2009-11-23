module Coulda
  SyntaxError = Class.new(StandardError)
end

require 'test/unit'

gem 'jeremymcanally-pending', '>= 0.1'
require 'pending'

require 'coulda/feature'
require 'coulda/scenario'

module Kernel
  def Feature(name, opts = {}, &block)
    f = Feature.new(name, opts)
    f.instance_eval &block if block_given?
    f.assert_presence_of_intent
    f
  end
end

require 'vendor/constantize'
require 'vendor/underscore'
