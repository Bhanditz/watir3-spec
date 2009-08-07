# encoding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe "Forms" do

  before :each do
    browser.goto(WatirSpec.files + "/forms_with_input_elements.html")
  end

  describe "#length" do
    it "returns the number of forms in the container" do
      browser.forms.length.should == 2
    end
  end

  describe "#[]n" do
    it "provides access to the nth form" do
      browser.forms[1].action.should == 'post_to_me'
      browser.forms[1].attribute_value('method').should == 'post'
    end
  end

  describe "#each" do
    it "iterates through forms correctly" do
      browser.forms.each_with_index do |f, index|
        f.name.should == browser.form(:index, index+1).name
        f.id.should == browser.form(:index, index+1).id
        f.class_name.should == browser.form(:index, index+1).class_name
      end
    end
  end

  

end
