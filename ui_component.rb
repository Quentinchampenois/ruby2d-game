class UiComponent
  attr_accessor :ui_elements

  def initialize
    @ui_elements = {
        text: []
    }
  end

  def add(element, kind)
    @ui_elements[kind] << element
    get_last_idx kind
  end

  def last_text
    last(:text)
  end

  def first_text
    first(:text)
  end

  def drop_text
    drop_elements(:text)
  end

  private

  def get_last_idx(kind)
    @ui_elements[kind].size - 1
  end

  def first(key)
    @ui_elements[key].first
  end

  def last(key)
    @ui_elements[key].last
  end

  def drop_elements(key)
    @ui_elements[key].clear
    puts @ui_elements[key]
  end
end
