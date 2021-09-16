class InvalidWordsValidator < ActiveModel::EachValidator
  def validate_each(record, _attribute, value)
    blacklist = YAML.load_file('./config/blacklist.yml')
    record.errors.add(:contain_blacklist_words, ': 不適切な言葉が含まれています。') if value.present? && blacklist.any? { |word| value.include?(word) }

    invalid_regex = { same_character_regex: /(.)\1{4,}/,
                      url_regex: %r{https?://[\w/:%#{Regexp.last_match(0)}?()~.=+\-]+},
                      html_regex: /<(".*?"|'.*?'|[^'"])*?>/ }

    if value.present? && invalid_regex.any? { | _invalid_key, invalid_value| invalid_value.match?(value) }
      record.errors.add(:contain_invalid_regex, ': url,htmlタグ,5文字以上の連続した単語は使えません。')
    end
  end
end
