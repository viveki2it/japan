# -*- encoding : utf-8 -*-
module StoresHelper
  def group_categories(store)
    catz = {}
    store.categories.each do |cat|
      catz[cat.parent.title] ||= []
      catz[cat.parent.title].push cat.title
    end
    catz
  end
end
