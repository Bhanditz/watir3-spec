# encoding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe "Ols" do

  before :each do
    browser.goto(WatirSpec.files + "/non_control_elements.html")
  end

  describe "#length" do
    it "returns the number of ols" do
      browser.ols.length.should == 2
    end
  end

  describe "#[]" do
    it "returns the ol at the given index" do
      browser.ols[1].id.should == "favorite_compounds"
    end
  end

  describe "#each" do
    it "iterates through ols correctly" do
      browser.ols.each_with_index do |ul, index|
        ul.name.should == browser.ol(:index, index+1).name
        ul.id.should == browser.ol(:index, index+1).id
        ul.value.should == browser.ol(:index, index+1).value
      end
    end
  end

end
