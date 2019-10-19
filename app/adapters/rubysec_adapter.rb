# frozen_string_literal: true

class RubysecAdapter < AdvisoryAdapter.new(:filepath, :gem, :cve,
                                           :osvdb, :url, :title,
                                           :date, :description, :cvss_v2,
                                           :cvss_v3, :patched_versions,
                                           :unaffected_versions, :related,
                                           keyword_init: true)

  def self.read_file(file_path, parser = Parsers::YamlAdapter)
    parsed_hash = parser.parse_file(file_path)
    everything = { filepath: file_path }.merge(parsed_hash).deep_symbolize_keys
    new(everything)
  end

  def identifier
    filepath.split('/')[-2..-1].join('-').gsub('.yml', '')
  end

  def to_h
    super.merge(identifier: identifier).except(:filepath).stringify_keys
  end
end
