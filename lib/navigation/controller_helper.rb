module Navigation
  module ControllerHelper
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      # Example:
      #
      #   class PostsController < ApplicationController
      #     navigation :main_menu, :content
      #     navigation :sub_menu,  :posts
      #   end
      #
      #   class CommentsController < ApplicationController
      #     navigation :main_menu, :content
      #     navigation :sub_menu,  :comments
      #   end
      def navigation(context, location, options = {})
        send :include, InstanceMethods
        before_filter(options) do |controller|
          controller.send(:define_navigation, context, location)
        end
      end
    end
  
    module InstanceMethods
      private
      def define_navigation(context, location)
        @_navigation_definitions ||= {}
        @_navigation_definitions.merge!(context => location)
      end
    end
  end
end
