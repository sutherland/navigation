require 'test/unit'
require 'rubygems'
require 'action_controller' 
require 'action_controller/test_process'
require File.dirname(__FILE__) + '/../rails/init.rb' 

ActionController::Base.view_paths = File.join(File.dirname(__FILE__), 'views')

ActionController::Routing::Routes.draw do |map|
  map.connect ':controller/:action/:id'
end
