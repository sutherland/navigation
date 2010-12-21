module Navigation
  module ViewHelper
    # Creates a navigation HTML element which wraps the content
    # supplied in the block. An element matching the current
    # navigational +context+ and +location+ will be given an
    # additional CSS class name of "selected".
    #
    # ==== Options
    #
    # * <tt>:tag => :span</tt> - Customize the HTML tag type used to
    #   build the navigation element.
    # * <tt>:class</tt> - String of CSS class names to add to the
    #   navigation element.
    # * <tt>:if</tt> - Specifies a method, proc or string to call to
    #   determine if the navigation element should be rendered.
    # * <tt>:unless</tt> - Specifies a method, proc or string to call
    #   to determine if the navigation element should not be rendered.
    #
    # ==== Examples
    #
    #   <%= navigate :main_menu, :posts do %>
    #     <%= link_to 'Posts' ... %>
    #   <% end %>
    #
    #   <%= navigate :main_menu, :comments, :tag => :li do %>
    #     <%= link_to 'Comments'... %>
    #   <% end %>
    #
    #   <%= navigate :admin_menu, :users, :if => administrator? do %>
    #     <%= link_to 'Users' ... %>
    #   <% end %>
    #
    #   <%= navigate :admin_menu, :users, :unless => !administrator? do %>
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

      content_tag(options.delete(:tag), capture(&block), options)
    end
  end
end
