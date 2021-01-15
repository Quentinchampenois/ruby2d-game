require_relative "../ui_component"
require "byebug"

class UiComponentText < UiComponent


  def update!(key, old, new)
    @ui_elements.compact.map do |obj|
      obj.text = new if obj.text == old
    end
  end
  private

  def search(key, value)
    @ui_elements.select do |obj|
      obj[key] == value
    end
  end

end
