require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Label" do

  before :all do
    @browser = Browser.new(WatirSpec.browser_options)
  end

  before :each do
    @browser.goto(WatirSpec.files + "/forms_with_input_elements.html")
  end

  # Exists method
  describe "#exists?" do
    it "returns true if the element exists" do
      @browser.label(:id, 'first_label').should exist
      @browser.label(:id, /first_label/).should exist
      @browser.label(:text, 'First name').should exist
      @browser.label(:text, /First name/).should exist
      @browser.label(:index, 1).should exist
      @browser.label(:xpath, "//label[@id='first_label']").should exist
     end

    it "returns true if the element exists (default how = :text)" do
      @browser.label("First name").should exist
    end

    it "returns false if the element does not exist" do
      @browser.label(:id, 'no_such_id').should_not exist
      @browser.label(:id, /no_such_id/).should_not exist
      @browser.label(:text, 'no_such_text').should_not exist
      @browser.label(:text, /no_such_text/).should_not exist
      @browser.label(:index, 1337).should_not exist
      @browser.label(:xpath, "//input[@id='no_such_id']").should_not exist
    end

    it "raises TypeError when 'what' argument is invalid" do
      lambda { @browser.label(:id, 3.14).exists? }.should raise_error(TypeError)
    end

    it "raises MissingWayOfFindingObjectException when 'how' argument is invalid" do
      lambda { @browser.label(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
    end
  end

  describe "click" do
    it "fires the onclick event" do
      clicked = nil
      @browser.add_listener(:alert) { |page, msg| clicked = msg }
      @browser.label(:id, 'first_label').click
      clicked.should == 'label'
    end
  end

  # Attribute methods
  describe "#id" do
    it "returns the id attribute if the label exists" do
      @browser.label(:index, 1).id.should == "first_label"
    end

    it "raises UnknownObjectException if the label doesn't exist" do
      lambda { @browser.label(:index, 1337).id }.should raise_error(UnknownObjectException)
    end
  end

  describe "#for" do
    it "returns the 'for' attribute if the label exists" do
      @browser.label(:index, 1).for.should == "new_user_first_name"
    end

    it "raises UnknownObjectException if the label doesn't exist" do
      lambda { @browser.label(:index, 1337).for }.should raise_error(UnknownObjectException)
    end
  end

  describe "#respond_to?" do
    it "returns true for all attribute methods" do
      @browser.label(:index, 1).should respond_to(:id)
      @browser.label(:index, 1).should respond_to(:for)
    end
  end


  after :all do
    @browser.close
  end
end

