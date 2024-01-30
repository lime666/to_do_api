# frozen_string_literal: true

class Task < ApplicationRecord
  STATUSES = %w[new_made in_progress done].freeze

  belongs_to :project

  enum status: { new_made: 'New', in_progress: 'In Progress', done: 'Done' }

  scope :new_made, -> { where(status: :new_made) }
  scope :in_progress, -> { where(status: :in_progress) }
  scope :done, -> { where(status: :done) }
end
