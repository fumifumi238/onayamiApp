class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def content_cannot_contain_blacklist_words
    blacklist = YAML.load_file('./config/blacklist.yml')
    if content.present? && blacklist.any?{ |word| content.include?(word) }
      errors.add(:contain_blacklist_words, ": 不適切な言葉は使用できません")
    end
  end

  def content_cannot_contain_invalid_regex(record, attribute, value)
    invalid_regex = { same_character_regex: %r!(.)\1{4,}!,
                      url_regex: %r!https?://[\w/:%#\$&\?\(\)~\.=\+\-]+!,
                      html_regex: %r!<(".*?"|'.*?'|[^'"])*?>!}
    if content.present? && invalid_regex.any?{|key,value| value.match?(content)}
      record.errors.add(:contain_invalid_regex, ":　使うことのできない文字列が含まれています")
    end
  end
end
