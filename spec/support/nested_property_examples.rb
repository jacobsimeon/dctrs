shared_examples "a nested property" do
  before :each do
    @child, @attrs = child_property_class.new, {}

    child_property_class
      .should_receive(:new)
      .with(@attrs)
      .and_return(@child)
  end

  it "passes the child property attributes to #new" do
    described_class.new({ property_name => @attrs })
  end

  it "sets the child property to the created instance" do
    parent = described_class.new({ property_name => @attrs })
    parent.send(property_name).should be(@child)
  end
end

shared_examples 'a nested collection' do
  before :each do
    @specs = 3.times.map do |i|
      { attrs: {}, item: child_collection_class.new, index: i }
    end

    @collection_attributes = {
      child_collection_name => @specs.map { |spec| spec[:attrs] }
    }

    @specs.each do |spec|
      child_collection_class
        .should_receive(:new)
        .with(spec[:attrs])
        .and_return(spec[:item])
    end
  end

  it 'constructs an instance for each item' do
    described_class.new @collection_attributes
  end

  it 'intializes the property to a collection of the constructed items' do
    parent = described_class.new @collection_attributes
    child_collection = parent.send(child_collection_name)

    @specs.each do |spec|
      child_collection[spec[:index]].should be(spec[:item])
    end
  end
end
