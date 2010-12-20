require 'test_helper'

class PostsController < ActionController::Base
  navigation :main_menu,    :content
  navigation :content_menu, :posts

  def index
    head :ok
  end
end

class ControllerTest < ActionController::TestCase
  tests PostsController
  
  def setup
    @controller = PostsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  
    @routes = ActionDispatch::Routing::RouteSet.new.tap do |r|
      r.draw do
        match ':controller(/:action(/:id))'
      end
    end
    
    PostsController.stubs(:_routes).returns(@routes)
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
