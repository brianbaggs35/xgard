require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:sessions).dependent(:destroy) }
  end

  describe 'authentication' do
    it 'authenticates with the correct password' do
      user = create(:user, password: 'Password123!')
      expect(user.authenticate('Password123!')).to eq(user)
    end

    it 'does not authenticate with the wrong password' do
      user = create(:user, password: 'Password123!')
      expect(user.authenticate('wrongpassword')).to be_falsey
    end
  end

  describe 'email normalisation' do
    it 'strips leading and trailing whitespace from the email' do
      user = create(:user, email_address: '  test@example.com  ')
      expect(user.email_address).to eq('test@example.com')
    end

    it 'converts the email to lowercase' do
      user = create(:user, email_address: 'TEST@EXAMPLE.COM')
      expect(user.email_address).to eq('test@example.com')
    end

    it 'strips whitespace and lowercases at the same time' do
      user = create(:user, email_address: '  TEST@EXAMPLE.COM  ')
      expect(user.email_address).to eq('test@example.com')
    end
  end
end
