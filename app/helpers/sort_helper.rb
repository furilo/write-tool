# frozen_string_literal: true

module SortHelper
  def sortable(_relation, column, title, options = {})
    matching_column = column.to_s == params[:sort]
    direction = (sort_direction == "asc") ? "desc" : "asc"

    link_to request.params.merge(sort: column, direction:), options do
      concat title
      if matching_column
        caret = (sort_direction == "asc") ? "up" : "down"
        concat " "
        concat tag.i(nil, class: "fas fa-caret-#{caret}")
      end
    end
  end
end
