module Mohawk
  module Adapters
    module UIA
      class Control
        include Mohawk::Waiter, Locators

        def initialize(adapter, locator)
          @parent = adapter.window.element
          @locator = sanitize(locator)
        end

        def click
          element.click
        end

        def exist?
          element != nil
        end

        def element
          @element ||= wait_for do
            scope = (@locator[:children_only] && :children) || :descendants
            @parent.find @locator.merge(scope: scope)
          end
        end

        def value
          element.name
        end
        alias_method :control_name, :value

        def view
          self
        end
      end
    end
  end
end