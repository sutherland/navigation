require 'test_helper'

class PagesController < ActionController::Base
  navigation :main_menu,    :content
  navigation :content_menu, :pages

  def index
    head :ok
  end
end

class ControllerTest < ActionController::TestCase
  tests PagesController
  
  def setup
    @controller = PagesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  
    @routes = ActionDispatch::Routing::RouteSet.new.tap do |r|
      r.draw do
        match ':controller(/:action(/:id))'
      end
    end
    
    PagesController.stubs(:_routes).returns(@routes)
  end
  
  should "define navigation definitions" do
    get :index
    definitions = @controller.instance_variable_get(:@_navigation_definitions)
  
    assert definitions.include?(:main_menu)
    assert_equal :content, definitions[:main_menu]
    
    assert definitions.include?(:content_menu)
    assert_equal :pages, definitions[:content_menu]
  end
end
