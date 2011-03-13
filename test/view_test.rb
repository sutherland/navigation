require 'test_helper'

class ViewHelperTest < ActionController::TestCase
  tests PostsController
  
  def setup
    setup_posts_controller
  end
  
  context "Navigation items" do
    setup do
      get :index
    end
    
    should "assign 'selected' class to current items" do
      assert_tag 'span', :attributes => { :class => 'selected' },
                         :descendant => { :tag => 'a', :content => 'test selected tag' }
    end
    
    should "be spans by default" do
      assert_tag 'span', :descendant => { :tag => 'a', :content => 'test default tag' }
    end
    
    should "allow specifying the html tag" do
      assert_tag 'li', :descendant => { :tag => 'a', :content => 'test :tag option' }
    end
    
    should "allow specifying css class names" do
      assert_tag 'span', :attributes => { :class => 'blue' },
                         :descendant => { :tag => 'a', :content => 'test :class option' }
    end
    
    should "be rendered when :if option is true" do
      assert_tag 'span', :descendant => { :tag => 'a', :content => 'test :if option is true' }
    end
    
    should "be rendered when :unless option is false" do
      assert_tag 'span', :descendant => { :tag => 'a', :content => 'test :unless option is false' }
    end
    
    should "not be rendered when :if option is false" do
      assert_no_tag 'span', :descendant => { :tag => 'a', :content => 'test :if option is false' }
    end
    
    should "not be rendered when :unless option is true" do
      assert_no_tag 'span', :descendant => { :tag => 'a', :content => 'test :unless option is true' }
    end
  end
end
