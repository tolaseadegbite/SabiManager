module CustomersHelper
  def tooltip_link(content, path, tooltip_id, tooltip_content)
    link_to content.truncate(10), path,
            data: { tooltip_target: tooltip_id, tooltip_placement: "top", turbo_frame: "_top" }
  end

  def tooltip_content(tooltip_id, tooltip_content)
    content_tag :div, id: tooltip_id, role: "tooltip",
                class: "absolute z-10 invisible inline-block px-3 py-2 text-sm font-medium text-white transition-opacity duration-300 bg-gray-900 rounded-lg shadow-sm opacity-0 tooltip dark:bg-gray-700" do
      tooltip_content
    end
  end
end
