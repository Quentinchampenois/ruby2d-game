# Top level class for storing and searching elements

class UiComponent
  attr_accessor :ui_elements

  def initialize
    @ui_elements = []
  end

  def lazy_register(&block)
    return unless block_given?

    register yield
  end

  def register(element, get_idx = false)
    add element

    last_idx if get_idx
  end

  def unregister(key, value)
    ids = pick(key, value)
    return if ids.nil? || ids.empty?

    drop_elements ids
  end

  def unregister_all(key, value)
    ids = search key, value
    return if ids.nil? || ids.empty?

    drop_elements ids
  end

  def pick(key, value)
    search(key, value).first
  end

  def pick_all(key, value)
    search(key, value)
  end

  private

  def search(*)
    raise NotImplementedError
  end

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
    return if element.nil?

    @ui_elements << element
  end
end
