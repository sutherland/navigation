require 'navigation'

ActionController::Base.send(:include, Navigation::ControllerHelper)
ActionView::Base.send(:include, Navigation::ViewHelper)
