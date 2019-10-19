# frozen_string_literal: true

class AdvisoryAdapter < Struct
  def initialize(hash)
    super(hash.slice(*members))
  end
end
