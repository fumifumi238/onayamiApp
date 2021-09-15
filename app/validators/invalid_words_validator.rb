class InvalidWordsValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)

    blacklist = YAML.load_file('./config/blacklist.yml')
    if value.present? && blacklist.any?{ |word| value.include?(word) }
      record.errors.add(:contain_blacklist_words,'')
    end

    invalid_regex = { same_character_regex: %r!(.)\1{4,}!,
                      url_regex: %r!https?://[\w/:%#\$&\?\(\)~\.=\+\-]+!,
                      html_regex: %r!<(".*?"|'.*?'|[^'"])*?>!}

    if value.present? && invalid_regex.any?{|invalid_key,invalid_value| invalid_value.match?(value)}
      record.errors.add(:contain_invalid_regex, '')
    end

  end

end
