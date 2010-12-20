require 'navigation'

ActionController::Base.send(:include, Navigation::ControllerMethods)
ActionView::Base.send(:include, Navigation::ViewHelper)
