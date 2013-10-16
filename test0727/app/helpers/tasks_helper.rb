# -*- encoding: utf-8 -*-
# 日本語を扱うため

module TasksHelper
   def navigation_links
      items = []
      items << link_or_text('登録されているキーワード', :tasks)
      items << link_or_text('登録していたキーワード(削除的な)', [:done, :tasks])
      content_tag(:ul, :class => 'navigation') { items.join.html_safe }
   end

   def finish_or_unfinish(task)
      if task.done?
	 link_to('もどす(検索を行うようにする)', [ :unfinish, task ], :method => :put)
      else
	 link_to('検索しない', [ :unfinish, task ], :method => :put)
      end
   end

   def delete_word(task)
      if task.done?
	 link_to('登録ワードから削除する', [ :delete_word_from_db, task ], :method => :put)
      end
   end

   def google_search(task)
      if task.done?
      else
	 link_to('Google検索する', [ :googleSearch, task ], :method => :put)
      end
   end


   private
   def link_or_text(text, resource)
      html_class = current_page?(resource) ? 'selected' : nil
      content_tag(:li, :class => html_class) do
	 link_to_unless_current(text, resource)
      end
   end

end
