module Navigation
  module ViewHelper
    # Examples:
    #
    #   <% navigate :main_menu, :posts do %>
    #     <%= link_to 'Posts' ... %>
    #   <% end %>
    #
    #   <% navigate :main_menu, :comments, :tag => :div do %>
    #     <%= link_to 'Comments'... %>
    #   <% end %>
    #
    #   <% navigate :admin_menu, :users, :if => administrator? do %>
    #     <%= link_to 'Users' ... %>
    #   <% end %>
    #
    #   <% navigate :admin_menu, :users, :unless => !administrator? do %>
    #     <%= link_to 'Users' ... %>
    #   <% end %>
    def navigate(context, location, options = {}, &block)
      return if options.include?(:if) && !options[:if]
      return if options.include?(:unless) && options[:unless]
      
      options[:tag] ||= :span
      options[:class] = "#{options[:class]} navigation_item".strip
      
      if @_navigation_definitions && @_navigation_definitions[context] == location
        options[:class] = "selected #{options[:class]}"
      end

      concat content_tag(options.delete(:tag), capture(&block), options)
    end
  end
end
