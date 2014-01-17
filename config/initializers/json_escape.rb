class ActionView::Base
  def json_escape(s)
    #fail
    result = s.to_s.gsub('/', '\/')
    s.html_safe? ? result.html_safe : result
  end

  alias j json_escape
end