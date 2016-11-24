module FontAwesomeHelper
  def font_awesome(kind, spin: false)
    content_tag :i, '', {
      class: "fa fa-#{ kind.to_s }"
    }
  end
end