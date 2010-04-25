require 'test_helper'

class PostsController < ActionController::Base
  navigation :main_menu, :posts
protected
  helper_method :signed_in?
  def signed_in?
    false
  end
end

module PostsTestHelper
  def setup
    @controller = PostsController.new
    @controller.request = @request = ActionController::TestRequest.new
    @controller.response = @response = ActionController::TestResponse.new
  end
end

class ControllerHelperTest < ActionController::TestCase
  include PostsTestHelper
  tests PostsController
  
  test "added navigation definitions" do
    get :index
    definitions = @controller.instance_variable_get(:@_navigation_definitions)
    
    assert definitions.include?(:main_menu)
    assert_equal :posts, definitions[:main_menu]
  end
end

class ViewHelperTest < ActionController::TestCase
  include PostsTestHelper
  tests PostsController
  
  test "items are spans by default" do
    get :index
    assert_tag 'span', :attributes => { :class => 'navigation_item' }
  end
  
  test "allows custom class options" do
    get :index
    assert_tag 'span', :attributes => { :class => 'priviledged navigation_item' },
                       :descendant => { :tag => 'a', :attributes => { :href => '/admin' }}
  end
  
  test "shouldn't render item when :if option is false" do
    get :index
    assert_no_tag 'span', :attributes => { :class => 'navigation_item' },
                          :descendant => { :tag => 'a', :attributes => { :href => '/users' }}
  end
  
  test "active items have 'selected' class" do
    get :index
    assert_tag 'span', :attributes => { :class => 'navigation_item selected' },
                       :descendant => { :tag => 'a', :attributes => { :href => '/posts' }}
  end
  
  test "inactive items don't have 'selected' class" do
    get :index
    assert_tag 'span', :attributes => { :class => 'navigation_item' },
                       :descendant => { :tag => 'a', :attributes => { :href => '/comments' }}
  end
end
