require 'rubygems'
require 'test/unit'
require 'action_controller'
require 'shoulda'
require File.dirname(__FILE__) + '/../init.rb'

ActionController::Base.view_paths = File.join(File.dirname(__FILE__), 'views')

class PostsController < ActionController::Base
  navigation :main_menu,    :content
  navigation :content_menu, :posts
end

def setup_posts_controller
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
