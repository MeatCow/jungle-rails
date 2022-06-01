# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true
end
