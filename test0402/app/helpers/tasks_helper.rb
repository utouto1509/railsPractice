# -*- encoding: utf-8 -*-

module TasksHelper

   def navigation_links
      items = []
      items << link_or_text('登録されているキーワード', :tasks)
      items << link_or_text('登録していたキーワード(削除的な)', [:done, :tasks])
      content_tag(:ul, :class => 'navigation') { items.join.html_safe }
   end

   private
   def link_or_text(text, resource)
      html_class = current_page?(resource) ? 'selected' : nil
      content_tag(:li, :class => html_class) do
	 link_to_unless_current(text, resource)
      end
   end

end
