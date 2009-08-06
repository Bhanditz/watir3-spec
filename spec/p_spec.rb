require File.dirname(__FILE__) + '/spec_helper.rb'

describe "P" do

  before :all do
    @browser = Browser.new(BROWSER_OPTIONS)
  end

  before :each do
    @browser.goto(WatirSpec.files + "/non_control_elements.html")
  end

  # Exists method
  describe "#exist?" do
    it "returns true if the 'p' exists" do
      @browser.p(:id, "lead").should exist
      @browser.p(:id, /lead/).should exist
      @browser.p(:text, "Dubito, ergo cogito, ergo sum.").should exist
      @browser.p(:text, /Dubito, ergo cogito, ergo sum/).should exist
      @browser.p(:class, "lead").should exist
      @browser.p(:class, /lead/).should exist
      @browser.p(:index, 1).should exist
      @browser.p(:xpath, "//p[@id='lead']").should exist
    end

    it "returns true if the element exists (default how = :id)" do
      @browser.p("lead").should exist
    end

    it "returns false if the 'p' doesn't exist" do
      @browser.p(:id, "no_such_id").should_not exist
      @browser.p(:id, /no_such_id/).should_not exist
      @browser.p(:text, "no_such_text").should_not exist
      @browser.p(:text, /no_such_text/).should_not exist
      @browser.p(:class, "no_such_class").should_not exist
      @browser.p(:class, /no_such_class/).should_not exist
      @browser.p(:index, 1337).should_not exist
      @browser.p(:xpath, "//p[@id='no_such_id']").should_not exist
    end

    it "raises TypeError when 'what' argument is invalid" do
      lambda { @browser.p(:id, 3.14).exists? }.should raise_error(TypeError)
    end

    it "raises MissingWayOfFindingObjectException when 'how' argument is invalid" do
      lambda { @browser.p(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
    end
  end

  # Attribute methods
  describe "#class_name" do
    it "returns the class attribute" do
      @browser.p(:index, 1).class_name.should == 'lead'
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      @browser.p(:index, 3).class_name.should == ''
    end

    it "raises UnknownObjectException if the p doesn't exist" do
      lambda { @browser.p(:id, 'no_such_id').class_name }.should raise_error(UnknownObjectException)
    end
  end

  describe "#id" do
    it "returns the id attribute" do
      @browser.p(:index, 1).id.should == "lead"
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      @browser.p(:index, 3).id.should == ''
    end

    it "raises UnknownObjectException if the p doesn't exist" do
      lambda { @browser.p(:id, "no_such_id").id }.should raise_error(UnknownObjectException)
      lambda { @browser.p(:index, 1337).id }.should raise_error(UnknownObjectException)
    end
  end

  describe "#name" do
    it "returns the name attribute" do
      @browser.p(:index, 2).name.should == "invalid_attribute"
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      @browser.p(:index, 3).name.should == ''
    end

    it "raises UnknownObjectException if the p doesn't exist" do
      lambda { @browser.p(:id, "no_such_id").name }.should raise_error(UnknownObjectException)
      lambda { @browser.p(:index, 1337).name }.should raise_error(UnknownObjectException)
    end
  end

  describe "#title" do
    it "returns the title attribute" do
      @browser.p(:index, 1).title.should == 'Lorem ipsum'
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      @browser.p(:index, 3).title.should == ''
    end

    it "raises UnknownObjectException if the p doesn't exist" do
      lambda { @browser.p(:id, 'no_such_id').title }.should raise_error( UnknownObjectException)
      lambda { @browser.p(:xpath, "//p[@id='no_such_id']").title }.should raise_error( UnknownObjectException)
    end
  end

  describe "#text" do
    it "returns the text of the p" do
      @browser.p(:index, 2).text.should == 'Sed pretium metus et quam. Nullam odio dolor, vestibulum non, tempor ut, vehicula sed, sapien. Vestibulum placerat ligula at quam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.'
    end

    it "returns an empty string if the element doesn't contain any text" do
      @browser.p(:index, 5).text.should == ''
    end

    it "raises UnknownObjectException if the p doesn't exist" do
      lambda { @browser.p(:id, 'no_such_id').text }.should raise_error( UnknownObjectException)
      lambda { @browser.p(:xpath , "//p[@id='no_such_id']").text }.should raise_error( UnknownObjectException)
    end
  end

  describe "#value" do
    it "returns the value attribute" do
      @browser.p(:index, 2).value.should == "invalid_attribute"
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      @browser.p(:index, 3).value.should == ''
    end

    it "raises UnknownObjectException if the p doesn't exist" do
      lambda { @browser.p(:id , "no_such_id").value }.should raise_error(UnknownObjectException)
      lambda { @browser.p(:index , 1337).value }.should raise_error(UnknownObjectException)
    end
  end

  describe "#respond_to?" do
    it "returns true for all attribute methods" do
      @browser.p(:index, 1).should respond_to(:class_name)
      @browser.p(:index, 1).should respond_to(:id)
      @browser.p(:index, 1).should respond_to(:name)
      @browser.p(:index, 1).should respond_to(:title)
      @browser.p(:index, 1).should respond_to(:text)
      @browser.p(:index, 1).should respond_to(:value)
    end
  end


  # Other
  describe "#to_s" do
    it "returns a human readable representation of the element" do
      @browser.p(:index, 1).to_s.should == "tag:          p\n" +
                                      "  id:           lead\n" +
                                      "  class:        lead\n" +
                                      "  title:        Lorem ipsum\n" +
                                      "  text:         Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur eu pede. Ut justo. Praesent feugiat, elit in feugiat iaculis, sem risus rutrum justo, eget fermentum dolor arcu non nunc."
    end

    it "raises UnknownObjectException if the p doesn't exist" do
      lambda { @browser.p(:xpath, "//p[@id='no_such_id']").to_s }.should raise_error( UnknownObjectException)
    end
  end

  after :all do
    @browser.close
  end

end