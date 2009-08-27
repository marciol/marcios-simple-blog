module ApplicationHelper

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

    def tag_cloud(tags, classes)
      max_count = tags.sort_by(&:count).last.count.to_f rescue 1.0
      
      tags.each do |tag|
        index = ((tag.count / max_count) * (classes.size - 1)).round
        debugger
        yield tag, classes[index]
      end
    end
end
