# encoding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe "TableBodies" do

  before :each do
    browser.goto(WatirSpec.files + "/tables.html")
  end

  describe "#length" do
    it "returns the correct number of table bodies (page context)" do
      browser.bodies.length.should == 5
    end

    it "returns the correct number of table bodies (table context)" do
      browser.table(:index, 1).bodies.length.should == 2
    end
  end

  describe "#[]" do
    it "returns the row at the given index (page context)" do
      browser.bodies[1].id.should == "first"
      browser.bodies[2].name.should == "second"
    end

    it "returns the row at the given index (table context)" do
      browser.table(:index, 1).bodies[1].id.should == "first"
      browser.table(:index, 1).bodies[2].name.should == "second"
    end
  end

  describe "#each" do
      it "iterates through table bodies correctly (table context)" do
        browser.bodies.each_with_index do |body, index|
          body.name.should == browser.tbody(:index, index+1).name
          body.id.should == browser.tbody(:index, index+1).id
        end
      end

      it "iterates through table bodies correctly (table context)" do
        table = browser.table(:index, 1)
        table.bodies.each_with_index do |body, index|
          body.name.should == table.body(:index, index+1).name
          body.id.should == table.body(:index, index+1).id
        end
      end
    end

  

end
