require 'spec_helper'

describe "conta/edit" do
  before(:each) do
    @contum = assign(:contum, stub_model(Contum,
      :nome => "MyString"
    ))
  end

  it "renders the edit contum form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => conta_path(@contum), :method => "post" do
      assert_select "input#contum_nome", :name => "contum[nome]"
    end
  end
end
