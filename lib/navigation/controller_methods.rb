module Navigation
  module ControllerMethods
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      # Adds a +before_filter+ to the controller which defines the
      # +location+ for the +context+.
      #
      # ==== Options
      #
      # * <tt>:options</tt> - A hash of filter options. See the Rails
      #   documentation for a list of acceptable filter options.
      #
      # ==== Examples
      #
      #   class PagesController < ApplicationController
      #     navigation :content_menu, :pages
      #   end
      #
      #   class PostsController < ApplicationController
      #     navigation :content_menu, :posts
      #   end
      #
      #   class UsersController < ApplicationController
      #     navigation :users_menu, :new,  :only => [:new, :create]
      #     navigation :users_menu, :edit, :only => [:edit, :update]
      #   end
      def navigation(context, location, options = {})
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
