# typed: true
# frozen_string_literal: true

class AdvisoryAdapter < Struct
  MEMBERS = %i[filepath gem cve osvdb url title date description
               cvss_v2 cvss_v3 patched_versions unaffected_versions
               related].freeze

  def initialize(hash)
    super(hash.slice(*members))
  end
end
