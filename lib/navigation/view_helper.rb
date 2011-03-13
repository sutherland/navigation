module Navigation
  module ViewHelper
    # Creates a HTML tag which wraps the content in the specified
    # block. Marks the tag as "selected" if it matches the location
    # currently held by the controller.
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
    #   <%= navigate :content, :posts do %>
    #     <%= link_to 'Posts' ... %>
    #   <% end %>
    #
    #   <%= navigate :content, :comments, :tag => :li do %>
    #     <%= link_to 'Comments'... %>
    #   <% end %>
    #
    #   <%= navigate :admin, :users, :if => administrator? do %>
    #     <%= link_to 'Users' ... %>
    #   <% end %>
    #
    #   <%= navigate :admin, :users, :unless => hacker? do %>
    #     <%= link_to 'Users' ... %>
    #   <% end %>
    def navigate(context, location, options = {}, &block)
      return if options.include?(:if) && !options[:if]
      return if options.include?(:unless) && options[:unless]
      
      # Use a "span" tag as the wrapper, unless specified otherwise.
      options[:tag] ||= :span
      
      # Mark the tag as "selected" if it matches the context &
      # location currently held by the controller.
      if @_navigation_definitions && @_navigation_definitions[context] == location
        options[:class] = "selected #{options[:class]}".strip
      end

      # Wrap and return the content.
      content_tag(options.delete(:tag), capture(&block), options)
    end
  end
end
