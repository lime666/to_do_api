# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:projects).dependent(:destroy) }
    it { should have_many(:tasks).through(:projects) }
  end

  describe 'validations' do
    let!(:user) { create :user }

    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }

    context 'email' do
      it 'valid' do
        expect(user.update(email: "new_email@new.com")).to be_truthy
      end

      it 'invalid' do
        expect(user.update(email: "new_email")).to be_falsey
      end
    end

    context 'password' do
      it 'valid' do
        expect(user.update(password: "123456Aa#")).to be_truthy
      end

      it 'less then 8 characters' do
        expect(user.update(password: "123Aa")).to be_falsey
      end

      it 'more then 8 characters' do
        expect(user.update(password: "123456Aadf$")).to be_truthy
      end

      it 'error message' do
        expect { user.update!(password: "123456") }.to raise_error(ActiveRecord::RecordInvalid,
                                                                   "Validation failed: Password is invalid")
      end
    end
  end
end
