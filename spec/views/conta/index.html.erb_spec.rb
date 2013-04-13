require 'spec_helper'

describe "conta/index" do
  before(:each) do
    assign(:conta, [
      stub_model(Contum,
        :nome => "Nome"
      ),
      stub_model(Contum,
        :nome => "Nome"
      )
    ])
  end

  it "renders a list of conta" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nome".to_s, :count => 2
  end
end
