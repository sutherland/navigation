require 'navigate'

ActionView::Base.send :include, Navigate::ActionView::InstanceMethods
ActionController::Base.extend Navigate::ActionController::ClassMethods
