module Navigate
  module ActionController
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      # Example:
      #
      #   class PostsController < ApplicationController
      #     navigation :main_menu, :posts
      #     navigation :sub_menu,  :active, :only => :index
      #     navigation :sub_menu,  :drafts, :only => :drafts
      #   end
      def navigation(context, location, options = {})
        before_filter(options) do |controller|
          controller.send(:define_navigation, context, location)
        end
      end
    end
  
  private
  
    def define_navigation(context, location)
      @_navigation_definitions ||= {}
      @_navigation_definitions.merge!(context => location)
    end
  end
  
  module ActionView
    # Example:
    #
    #   <% navigate :main_menu, :posts do %>
    #     <%= link_to 'Posts', posts_path %>
    #   <% end %>
    #
    #   <% navigate :main_menu, :comments do %>
    #     <%= link_to 'Comments', comments_path %>
    #   <% end %>
    #
    #   <% navigate :main_menu, :users, :unless => !current_user.admin? do %>
    #     <%= link_to 'Users', users_path %>
    #   <% end %>
    #
    # Renders as:
    #
    #   <span class="navigation_item selected">
    #     <a href="/posts">Posts</a>
    #   </span>
    #
    #   <span class="navigation_item">
    #     <a href="/comments">Comments</a>
    #   </span>
    #
    #   <span class="navigation_item">
    #     <a href="/users">Users</a>
    #   </span>
    def navigate(context, location, options = {}, &block)
      options[:tag] ||= :span
      options[:class] = "#{options[:class]} navigation_item".strip
      
      # Don't render navigation when options[:if] is false
      return if options.include?(:if) && !options[:if]
      
      # Don't render navigation when options[:unless] is true
      return if options.include?(:unless) && options[:unless]
      
      if @_navigation_definitions && @_navigation_definitions[context] == location
        options[:class] += " selected"
      end

      concat content_tag(options.delete(:tag), capture(&block), options)
    end
  end
end
