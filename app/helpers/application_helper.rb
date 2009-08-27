module ApplicationHelper

    include TagsHelper

    def validate_i18n
      "plugins/validate_" + I18n.locale
      rescue
        "plugins/validate_en"
    end

    def javascript(*files)
      content_for(:head) { javascript_include_tag(*files) }
    end

    def stylesheet(*files)
      content_for(:head) { stylesheet_link_tag(*files) }
    end

    def tag_classes
      %w(tag1 tag2 tag3 tag4 tag5 tag6 tag7 tag8 tag9 tag10)
    end
end
