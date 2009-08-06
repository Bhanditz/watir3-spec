require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Tables" do

  before :all do
    @browser = Browser.new(BROWSER_OPTIONS)
  end

  before :each do
    @browser.goto(WatirSpec.files + "/tables.html")
  end

  describe "#length" do
    it "returns the number of tables" do
      @browser.tables.length.should == 4
    end
  end

  describe "#[]" do
    it "returns the p at the given index" do
      @browser.tables[1].id.should == "axis_example"
      @browser.tables[2].id.should == "outer"
      @browser.tables[3].id.should == "inner"
    end
  end

  describe "#each" do
    it "iterates through tables correctly" do
      @browser.tables.each_with_index do |t, index|
        t.name.should == @browser.table(:index, index+1).name
        t.id.should == @browser.table(:index, index+1).id
        t.value.should == @browser.table(:index, index+1).value
      end
    end
  end

  after :all do
    @browser.close
  end

end

