require "../ui_component"

class UiComponentText < UiComponent
  private

  def search(key, value)
    @ui_elements.select do |obj|
      obj[key] == value
    end
  end
end
