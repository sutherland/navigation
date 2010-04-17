require 'navigate'

ActionController::Base.send(:include, Navigate::ActionController)
ActionView::Base.send(:include, Navigate::ActionView)