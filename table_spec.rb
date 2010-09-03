# encoding: utf-8
require File.expand_path('spec_helper', File.dirname(__FILE__))

describe "Table" do

  before :each do
    browser.goto(WatirSpec.files + "/tables.html")
  end

  # Exists
  describe "#exists?" do
    it "returns true if the table exists" do
      browser.table(:id, 'axis_example').should exist
      browser.table(:id, /axis_example/).should exist
      browser.table(:index, 0).should exist
      browser.table(:xpath, "//table[@id='axis_example']").should exist
    end

    it "returns the first table if given no args" do
      browser.table.should exist
    end

    it "returns false if the table does not exist" do
      browser.table(:id, 'no_such_id').should_not exist
      browser.table(:id, /no_such_id/).should_not exist
      browser.table(:index, 1337).should_not exist
      browser.table(:xpath, "//table[@id='no_such_id']").should_not exist
    end

    it "checks the tag name when locating by xpath" do
      browser.table(:xpath, "//table//td").should_not exist
      browser.table(:xpath, "//table").should exist
    end

    it "raises TypeError when 'what' argument is invalid" do
      lambda { browser.table(:id, 3.14).exists? }.should raise_error(TypeError)
    end

    it "raises MissingWayOfFindingObjectException when 'how' argument is invalid" do
      lambda { browser.table(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
    end
  end

  describe "#length" do
    it "returns the number of rows" do
      browser.table(:id, 'outer').rows.length.should == 3
      browser.table(:id, 'inner').rows.length.should == 1
    end
  end

  # Other
  describe "#to_a" do
    it "returns a two-dimensional array representation of the table" do
      browser.table(:id, 'inner').to_a.should == [["Table 2, Row 1, Cell 1", "Table 2, Row 1, Cell 2"]]
    end
  end

  describe "#click" do
    it "fires the table's onclick event" do
      browser.table(:id, 'inner').click
      messages.first.should == 'table'
    end
  end

  bug "http://github.com/jarib/watir-webdriver/issues/#issue/2", :webdriver do
    describe "#row_count" do
      it "counts the number of rows correctly" do
        browser.table(:id, 'inner').row_count.should == 1
        browser.table(:id, 'outer').row_count.should == 3
      end

      it "raises an UnknownObjectException if the table doesn't exist" do
        lambda { browser.table(:id, 'no_such_id').row_count }.should raise_error(UnknownObjectException)
        lambda { browser.table(:index, 1337).row_count }.should raise_error(UnknownObjectException)
      end
    end
  end

  bug "http://github.com/jarib/watir-webdriver/issues/#issue/2", :webdriver do
    describe "#row_values" do
      it "gets row values" do
        browser.table(:id, 'outer').row_values(0).should == ["Table 1, Row 1, Cell 1", "Table 1, Row 1, Cell 2"]
        browser.table(:id, 'inner').row_values(0).should == ["Table 2, Row 1, Cell 1", "Table 2, Row 1, Cell 2"]
        browser.table(:id, 'outer').row_values(2).should == ["Table 1, Row 3, Cell 1", "Table 1, Row 3, Cell 2"]
      end
    end
  end

  bug "http://github.com/jarib/watir-webdriver/issues/#issue/2", :webdriver do
    describe "#column_count" do
      it "counts the number of columns correctly" do
        browser.table(:id, 'inner').column_count.should == 2
        browser.table(:id, 'outer').column_count.should == 2
      end

      it "raises an UnknownObjectException if the table doesn't exist" do
        lambda { browser.table(:id, 'no_such_id').column_count }.should raise_error(UnknownObjectException)
        lambda { browser.table(:index, 1337).column_count }.should raise_error(UnknownObjectException)
      end
    end
  end

  bug "http://github.com/jarib/watir-webdriver/issues/#issue/2", :webdriver do
    describe "#column_values" do
      it "gets column values" do
        browser.table(:id, 'inner').column_values(0).should == ["Table 2, Row 1, Cell 1"]
        browser.table(:id, 'outer').column_values(0).should == ["Table 1, Row 1, Cell 1", "Table 1, Row 2, Cell 1", "Table 1, Row 3, Cell 1"]
      end

      it "raises UnknownCellException when trying to locate non-existing cell" do
        lambda { browser.table(:id, 'inner').column_values(1337) }.should raise_error(UnknownCellException)
      end
    end
  end

  describe "#[]" do
    it "returns the nth child row" do
      browser.table(:id, 'outer')[0].id.should == "outer_first"
      browser.table(:id, 'inner')[0].id.should == "inner_first"
      browser.table(:id, 'outer')[2].id.should == "outer_last"
    end


    bug "http://github.com/jarib/watir-webdriver/issues/issue/26", :webdriver do
      it "raises UnknownRowException if the index is out of bounds" do
        lambda { browser.table(:id, 'outer')[1337] }.should raise_error(UnknownRowException)
      end
    end
  end

  bug "http://github.com/jarib/watir-webdriver/issues/#issue/2", :webdriver do
    describe "#child_row" do
      it "returns the nth child row" do
        browser.table(:id, 'outer').child_row(0).id.should == "outer_first"
        browser.table(:id, 'inner').child_row(0).id.should == "inner_first"
        browser.table(:id, 'outer').child_row(2).id.should == "outer_last"
      end
      it "raises UnknownRowException if the index is out of bounds" do
        lambda { browser.table(:id, 'outer').child_row(1337) }.should raise_error(UnknownRowException)
      end
    end
  end

  bug "http://github.com/jarib/watir-webdriver/issues/#issue/2", :webdriver do
    describe "#child_cell" do
      it "returns the nth child row" do
        browser.table(:id, 'outer').child_cell(4).text.should == "Table 1, Row 3, Cell 1"
      end
      it "raises UnknownCellException if the index is out of bounds" do
        lambda { browser.table(:id, 'outer').child_cell(1337) }.should raise_error(UnknownCellException)
      end
    end
  end

  bug "http://github.com/jarib/watir-webdriver/issues/#issue/2", :webdriver do
    describe "#each" do
      it "iterates through the table's rows" do
        ids = ["outer_first", "outer_second", "outer_last"]
        browser.table(:id, 'outer').each_with_index do |r, idx|
          r.id.should == ids[idx]
        end
      end
    end
  end

  bug "http://github.com/jarib/watir-webdriver/issues/#issue/2", :webdriver do
    describe "#body" do
      it "returns the correct instance of TableBody" do
        body = browser.table(:index, 0).tbody(:id, 'first')
        
        body.should be_instance_of(TableBody)
        
        body[0][0].text.should == "March 2008"
      end
    end
  end

  bug "http://github.com/jarib/watir-webdriver/issues/#issue/2", :webdriver do
    describe "#bodies" do
      it "returns the correct instance of TableBodies" do
        bodies = browser.table(:index, 0).tbodys
        
        bodies.should be_instance_of(TableBodies)
        
        bodies[0].id.should == "first"
        bodies[1].id.should == "second"
      end
    end
  end

end
