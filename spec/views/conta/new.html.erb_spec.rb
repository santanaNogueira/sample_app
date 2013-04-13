require 'spec_helper'

describe "conta/new" do
  before(:each) do
    assign(:contum, stub_model(Contum,
      :nome => "MyString"
    ).as_new_record)
  end

  it "renders new contum form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => conta_path, :method => "post" do
      assert_select "input#contum_nome", :name => "contum[nome]"
    end
  end
end
