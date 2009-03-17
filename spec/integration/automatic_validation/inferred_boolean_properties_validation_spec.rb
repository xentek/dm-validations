require 'pathname'

__dir__ = Pathname(__FILE__).dirname.expand_path
require __dir__.parent.parent + 'spec_helper'
require __dir__ + 'spec_helper'

describe "A model with an Boolean property" do
  before :all do
    @model = HasNullableBoolean.new(:id => 1)
  end

  describe "assigned to true" do
    before :all do
      @model.set(:bool => true)
    end

    it_should_behave_like "valid model"
  end

  describe "assigned to false" do
    before :all do
      @model.set(:bool => false)
    end

    it_should_behave_like "valid model"
  end

  describe "assigned to a nil" do
    before :all do
      @model.set(:bool => nil)
    end

    it_should_behave_like "valid model"
  end
end