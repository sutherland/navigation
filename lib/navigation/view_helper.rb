module Navigation
  module ViewHelper
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
    # Renders as:
    #
    #   <span class="navigation_item selected">
    #     <a href="/posts">Posts</a>
    #   </span>
    #
    #   <span class="navigation_item">
    #     <a href="/comments">Comments</a>
    #   </span>
    def navigate(context, location, options = {}, &block)
      options[:tag] ||= :span
      options[:class] = "#{options[:class]} navigation_item".strip
      
      if options.include?(:if)
        return unless options[:if]
      end
      
      if @_navigation_definitions && @_navigation_definitions[context] == location
        options[:class] += " selected"
      end

      concat content_tag(options.delete(:tag), capture(&block), options)
    end
  end
end
