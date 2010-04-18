require 'navigation/controller_helper'
require 'navigation/view_helper'

require 'action_controller'
require 'action_view'

ActionController::Base.send(:include, Navigation::ControllerHelper)
ActionView::Base.send(:include, Navigation::ViewHelper)