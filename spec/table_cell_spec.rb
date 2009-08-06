require File.dirname(__FILE__) + '/spec_helper.rb'

describe "TableCell" do

  before :all do
    @browser = Browser.new(WatirSpec.browser_options)
  end

  before :each do
    @browser = Browser.new(WatirSpec.browser_options)
    @browser.goto(WatirSpec.files + "/tables.html")
  end

  # Exists
  describe "#exists" do
    it "returns true when the table cell exists" do
      @browser.cell(:id, 't1_r2_c1').should exist
      @browser.cell(:id, /t1_r2_c1/).should exist
      @browser.cell(:text, 'Table 1, Row 3, Cell 1').should exist
      @browser.cell(:text, /Table 1/).should exist
      @browser.cell(:index, 1).should exist
      @browser.cell(:xpath, "//td[@id='t1_r2_c1']").should exist
    end

    it "returns true if the element exists (default how = :id)" do
      @browser.cell("t1_r2_c1").should exist
    end

    it "returns false when the table cell does not exist" do
      @browser.cell(:id, 'no_such_id').should_not exist
      @browser.cell(:id, /no_such_id/).should_not exist
      @browser.cell(:text, 'no_such_text').should_not exist
      @browser.cell(:text, /no_such_text/).should_not exist
      @browser.cell(:index, 1337).should_not exist
      @browser.cell(:xpath, "//td[@id='no_such_id']").should_not exist
    end

    it "raises TypeError when 'what' argument is invalid" do
      lambda { @browser.cell(:id, 3.14).exists? }.should raise_error(TypeError)
    end

    it "raises MissingWayOfFindingObjectException when 'how' argument is invalid" do
      lambda { @browser.cell(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
    end
  end

  describe "#click" do
    it "fires the table's onclick event" do
      clicked = []
      @browser.add_listener(:alert) { |page, msg| clicked << msg }
      @browser.cell(:id, 't2_r1_c1').click
      clicked.should include('td')
    end
  end


  # Attribute methods
  describe "#text" do
    it "returns the text inside the table cell" do
      @browser.cell(:id, 't1_r2_c1').text.should == 'Table 1, Row 2, Cell 1'
      @browser.cell(:id, 't2_r1_c1').text.should == 'Table 2, Row 1, Cell 1'
    end
  end

  describe "#colspan" do
    it "gets the colspan attribute" do
      @browser.cell(:id, 'colspan_2').colspan.should == 2
      @browser.cell(:id, 'no_colspan').colspan.should == 1
    end
  end

  describe "#respond_to?" do
    it "returns true for all attribute methods" do
      @browser.cell(:index, 1).should respond_to(:text)
      @browser.cell(:index, 1).should respond_to(:colspan)
    end
  end


  after :all do
    @browser.close
  end

end