class Article < ApplicationRecord
  attr_accessor :requester_id

  validate :validate_ownership, on: [:update, :destroy]

  private

  def validate_ownership
    if user_id != requester_id
      errors.add(:user_id, 'not owned by user')
    end
  end
end

