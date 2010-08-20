# encoding: utf-8
require File.expand_path('spec_helper', File.dirname(__FILE__))

describe "Ps" do

  before :each do
    browser.goto(WatirSpec.files + "/non_control_elements.html")
  end

  describe "#length" do
    it "returns the number of ps" do
      browser.ps.length.should == 5
    end
  end

  describe "#[]" do
    it "returns the p at the given index" do
      browser.ps[0].id.should == "lead"
    end
  end

  describe "#each" do
    it "iterates through ps correctly" do
      count = 0

      browser.ps.each_with_index do |p, index|
        p.id.should == browser.p(:index, index).id
        p.value.should == browser.p(:index, index).value

		count += 1
      end

      count.should > 0
    end
  end

end
