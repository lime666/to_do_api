# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'associations' do
    it { should belong_to(:project) }
  end

  describe 'enum' do
    let!(:task) { create :task }
    it { expect(Task::STATUSES).to include task.status }
  end

  describe 'scopes' do
    context 'new_made' do
      let!(:new_tasks) { create_list :task, 5, :new_made }

      it { expect(Task.new_made).to include(*new_tasks) }
    end

    context 'in_progress' do
      let!(:in_progress_tasks) { create_list :task, 5, :in_progress }

      it { expect(Task.in_progress).to include(*in_progress_tasks) }
    end

    context 'done' do
      let!(:done_tasks) { create_list :task, 5, :done }

      it { expect(Task.done).to include(*done_tasks) }
    end
  end
end
