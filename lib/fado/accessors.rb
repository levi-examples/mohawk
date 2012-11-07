module Fado
  module Accessors
    def window(locator)
      define_method("which_window") do
        locator
      end
    end
    
    def text(name, locator)
      define_method("#{name}") do 
        adapter.get_text(locator)
      end
      define_method("#{name}=") do |text|
        adapter.set_text(text, locator)
      end
      define_method("clear_#{name}") do
        adapter.clear_text(locator)
      end
    end

    def button(name, locator)
      define_method("#{name}") do |&block|
        adapter.click_button(locator, &block)
      end
      define_method("#{name}_value") do
        adapter.get_button_value(locator)
      end
    end

    def combo_box(name, locator)
      define_method("#{name}") do
        adapter.get_combo_box_value(locator)
      end
      define_method("#{name}=") do |item|
        adapter.set_combo_box_value(item, locator)
      end
      define_method("#{name}_options") do
        adapter.get_combo_box_options(locator)
      end
    end

    def checkbox(name, locator)
      define_method("#{name}") do
        adapter.is_checked(locator)
      end
      define_method("#{name}=") do |should_check|
        adapter.check(should_check, locator)
      end
      define_method("#{name}_value") do
        adapter.get_check_value(locator)
      end
    end

    def radio(name, locator)
      define_method("#{name}") do
        adapter.set_radio(locator)
      end
      define_method("#{name}?") do
        adapter.radio_is_set? locator
      end
    end
  end
end
