module Mohawk
  module Adapters
    module UIA
      class Table < Control
        include ElementLocator

        def select(which)
          find_row_with(which).select
        end

        def add(which)
          find_row_with(which).add_to_selection
        end

        def clear(which)
          find_row_with(which).remove_from_selection
        end

        def count
          table.row_count
        end

        def headers
          table.headers.map &:name
        end

        def find_row_with(row_info)
          found_row = case row_info
            when Hash
              find_by_hash(row_info)
            else
              find(row_info)
          end
          raise "A row with #{row_info} was not found" unless found_row
          found_row
        end

        private
        def table
          element.as :table
        end

        def find_by_hash(which)
        end

        def all_items
          table.rows.map do |row|
            row.as(:selection_item)
          end
        end
      end
    end
  end
end