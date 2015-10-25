# encoding: utf-8
# Micropost helper
module MicropostsHelper
	def microposts_tree_for(microposts)
    microposts.map do |micropost, nested_microposts|
      render(micropost) +
          (nested_microposts.size > 0 ? content_tag(:div, microposts_tree_for(nested_microposts), class: "replies") : nil)
    end.join.html_safe
  end
end
