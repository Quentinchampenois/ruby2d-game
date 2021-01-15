class UiComponent
  attr_accessor :ui_elements

  def initialize
    @ui_elements = []
  end

  def register(element, get_idx = false)
    add element

    last_idx if get_idx
  end

  def unregister(prop)
    ids = search prop
    return if ids.nil? || ids.empty?

    drop_elements ids
  end

  def search(_)
    raise NotImplementedError
  end

  private

  def find
    @ui_elements.each { |element| }
  end

  def last_idx
    @ui_elements.size - 1
  end

  def drop_elements(idx)
    return @ui_elements[idx].clear if idx.is_a? Integer

    idx.each { |id| @ui_elements[id].clear }
  end

  def add(element)
    return if element.nil? || element.empty?

    @ui_elements << element
  end
end
