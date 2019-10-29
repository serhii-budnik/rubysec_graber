# typed: strict
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :trackable

  scope :confirmed, -> { where.not(confirmed_at: nil) }
end
