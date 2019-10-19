# frozen_string_literal: true

class AdvisoryAdapter < Struct
  def initialize(hsh)
    super(*members.map { |member| hsh[member.to_s] })
  end
end
