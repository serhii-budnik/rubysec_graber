# typed: true
# frozen_string_literal: true

module Parsers
  class YamlAdapter
    def self.parse_file(file_path)
      YAML.load_file(file_path)
    end
  end
end
