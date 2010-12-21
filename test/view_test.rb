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
    
    should "be span tag by default" do
      assert_tag 'span', :attributes => { :class => 'navigation_item' },
                         :descendant => { :tag => 'a', :content => 'test default tag' }
    end
    
    should "allow specifying the html tag" do
      assert_tag 'li', :attributes => { :class => 'navigation_item' },
                       :descendant => { :tag => 'a', :content => 'test :tag option' }
    end
    
    should "allow specifying css class names" do
      assert_tag 'span', :attributes => { :class => 'blue navigation_item' },
                         :descendant => { :tag => 'a', :content => 'test :class option' }
    end
    
    should "render when :if option is true" do
      assert_tag 'span', :attributes => { :class => 'navigation_item' },
                         :descendant => { :tag => 'a', :content => 'test :if option is true' }
    end
    
    should "render when :unless option is false" do
      assert_tag 'span', :attributes => { :class => 'navigation_item' },
                         :descendant => { :tag => 'a', :content => 'test :unless option is false' }
    end
    
    should "assign 'selected' class to current items" do
      assert_tag 'span', :attributes => { :class => 'selected navigation_item' },
                         :descendant => { :tag => 'a', :content => 'Posts' }
    end
  end
end
