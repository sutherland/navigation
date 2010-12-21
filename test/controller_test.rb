require 'test_helper'

class ControllerTest < ActionController::TestCase
  tests PostsController
  
  def setup
    setup_posts_controller
  end
  
  should "define navigation definitions" do
    get :index
    definitions = @controller.instance_variable_get(:@_navigation_definitions)
  
    assert definitions.include?(:main_menu)
    assert_equal :content, definitions[:main_menu]
    
    assert definitions.include?(:content_menu)
    assert_equal :posts, definitions[:content_menu]
  end
end
