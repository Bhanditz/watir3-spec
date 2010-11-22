# encoding: utf-8
require File.expand_path('../watirspec_helper', __FILE__)

describe 'Collection' do
  before :each do
    browser.goto(fixture('non_control_elements.html'))
    @collection = window.find_elements_by_tag(:div)
  end

  # elements
  describe '#find_elements_by_tag' do
    it 'is not empty if the tag exists under the collection' do
      @collection.find_elements_by_tag(:a).should_not be_empty
    end

    it 'contains all elements of the tag name under the collection' do
      @collection.find_elements_by_tag(:a).all? do |element|
        element.tag_name == 'a'
      end.should be_true
    end

    it 'contains only elements restricted by the selector' do
      window.find_elements_by_tag(:span, :title => 'Lorem ipsum').all? do |element|
        element.attr(:title) == 'Lorem ipsum'
      end.should be_true
    end

    it 'is empty if the elements do not exist' do
      window.find_elements_by_tag(:hoobaflooba).should be_empty
    end
  end

  # length
  describe '#length' do
    it 'is the number of items in the collection' do
      @collection.length.should == 12
    end
  end

  describe '#attr' do
    it 'returns the given attribute of the first element' do
      @collection.attr(:id).should == 'outer_container'
    end
  end

  # attrs(what)
  describe 'attrs' do
    it 'returns the attributes of each of the elements in the collection' do
      @collection.attrs(:id)[0].should == 'outer_container'
      @collection.attrs(:id)[1].should == 'header'
      @collection.attrs(:id)[8].should == 'hidden'
    end
  end

  # states
  # ------

  # checked?
  describe '#checked?' do
    before :each do
      browser.goto(fixture('forms_with_input_elements.html'))
      @boxes = window.find_elements_by_tag(:input, :type => 'checkbox')
    end

    it 'is false if one of the elements is not checked' do
      @boxes.checked?.should be_false
    end

    it 'is false if one of the elements is not checked' do
      @boxes.each do |box|
        box.check!
      end
      @boxes.checked?.should be_true
    end
  end

  # check!
  describe '#check!' do
    it 'checks all of the checkboxes' do
      browser.goto(fixture('forms_with_input_elements.html'))
      @boxes = window.find_elements_by_tag(:input, :type => 'checkbox')

      @boxes.check!
      @boxes.all? do |box|
        box.checked? == true
      end.should be_true
    end
  end

  # uncheck!
  describe '#uncheck!' do
    it 'unchecks all of the checkboxes' do
      browser.goto(fixture('forms_with_input_elements.html'))
      @boxes = window.find_elements_by_tag(:input, :type => 'checkbox')

      @boxes.uncheck!
      @boxes.all? do |box|
        box.checked? == false
      end.should be_true
    end
  end

  # toggle_check!
  describe '#toggle_check!' do
    it 'toggles the checked state of all of the checkboxes' do
      browser.goto(fixture('forms_with_input_elements.html'))
      @boxes = window.find_elements_by_tag(:input, :type => 'checkbox')

      @boxes.toggle_check!
      @boxes.all? do |box|
        box.checked? == true
      end.should be_true
    end
  end

  # enabled?
  describe '#enabled?' do
    before :each do
      browser.goto(fixture('forms_with_input_elements.html'))
    end

    it 'returns true if all collection elements are enabled' do
      fieldset = window.find_elements_by_id('delete_user').first.children.first
      fieldset.children.enabled?.should be_true
    end

    it 'returns false if any collection elements are disabled' do
      fieldset = window.find_elements_by_id('new_user').first.children.first
      fieldset.children.enabled?.should be_false
    end
  end

  # enable!
  describe '#enable!' do
    it 'enables all elements in the collection' do
      browser.goto(fixture('forms_with_input_elements.html'))
      fieldset = window.find_elements_by_id('delete_user').first.children.first
      fieldset.children.enable!
      window.find_elements_by_id('new_user_species').enabled?.should be_true
    end
  end

  # disable!
  describe '#disable' do
    it 'disables all elements in the collection' do
      browser.goto(fixture('forms_with_input_elements.html'))
      fieldset = window.find_elements_by_id('delete_user').first.children.first
      fieldset.children.disable!
      fieldset.children.all? do |element|
        element.enabled? == false
      end.should be_true
    end
  end

  # visible?
  describe '#visible' do
    it 'is true if all the elements are visible' do
      window.find_elements_by_tag(:ul).visible?.should be_true
    end

    it 'is false if not all elements are visible' do
      @collection.visible?.should be_false
    end
  end
  # show!
  describe '#show!' do
    it 'shows all the elements' do
      @collection.show!
      window.find_elements_by_id('hidden').visible?.should be_true
    end
  end

  # hide!
  describe '#hide!' do
    it 'hides all the elements' do
      @collection.hide!
      window.find_elements_by_id('outer_container').visible?.should be_false
    end
  end

  # actions
  # -------
end
