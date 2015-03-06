require 'helper'

class DockerTagResolverOutputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  def create_driver(conf=CONFIG,tag='test')
    Fluent::Test::OutputTestDriver.new(Fluent::DockerTagResolver, tag).configure(conf)
  end

end
