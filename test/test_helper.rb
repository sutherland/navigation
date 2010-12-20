require 'rubygems'
require 'test/unit'
require 'action_controller'
require 'shoulda'
require File.dirname(__FILE__) + '/../init.rb'

ActionController::Base.view_paths = File.join(File.dirname(__FILE__), 'views')
