# typed: strong
# frozen_string_literal: true

class Advisory < ApplicationRecord
  validates :identifier, presence: true, uniqueness: true
end
