module Navigate
  module ActionController
    module ClassMethods
      # Example:
      #
      #   class PostsController < ApplicationController
      #     navigate :main_menu, :posts
      #     navigate :sub_menu,  :active, :only => :index
      #     navigate :sub_menu,  :drafts, :only => :drafts
      #   end
      def navigate(namespace, item, options = {})
        before_filter(options) do |controller|          
          namespaces = controller.instance_variable_get(:@navigation_namespaces) || {}
          namespaces.merge!(namespace => item)
          controller.instance_variable_set(:@navigation_namespaces, namespaces)
        end
      end
    end
  end
  
  module ActionView
    module InstanceMethods
      # Example:
      #
      #   <% navigate :main_menu, :posts do %>
      #     <a href='/posts'>Posts</a>
      #   <% end %>
      #
      #   <% navigate :main_menu, :users, :unless => !authorized? do %>
      #     <a href='/users'>Users</a>
      #   <% end %>
      #
      # Renders as:
      #
      #   <li class="selected">
      #     <a href='/posts'>Posts</a>
      #   </li>
      #
      #   <li>
      #     <a href='/users'>Users</a>
      #   </li>
      def navigate(namespace, item, options = {}, &block)
        options[:tag] ||= :li
        options[:class] = "#{options[:class]} nav_item".strip
      
        # navigate :main_menu, :settings, :if => authorized?
        return if options.include?(:if) and !options[:if]
      
        # navigate :main_menu, :settings, :unless => !authorized?
        return if options.include?(:unless) and options[:unless]

        if defined?(@navigation_namespaces) && @navigation_namespaces[namespace] == item
          options.merge! :class => "#{options[:class]} selected".strip
        end

        concat content_tag(options.delete(:tag), capture(&block), options)
      end
    end
  end
  
  module TestHelper
    # Example:
    #
    #   class PostsControllerTest < ActionController::TestCase
    #     assert_navigates :main_menu, :posts
    #     assert_navigates :sub_menu,  :active, :only => :index
    #     assert_navigates :sub_menu,  :drafts, :only => :drafts
    #   end
    def assert_navigates(namespace, item, options = {})
      # TODO
    end
  end
end
