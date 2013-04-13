require 'spec_helper'

describe "conta/show" do
  before(:each) do
    @contum = assign(:contum, stub_model(Contum,
      :nome => "Nome"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nome/)
  end
end
