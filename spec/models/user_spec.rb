require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = build(:user) # Using FactoryBot to create a user with valid attributes
    expect(user).to be_valid
  end

  it 'is not valid without a nickname' do
    user = build(:user, nickname: nil)
    expect(user).to_not be_valid
  end

  it 'is not valid without a valid email' do
    user = build(:user, email: 'invalid_email')
    expect(user).to_not be_valid
  end

  # Add more tests for other validations (e.g., password, full name, birthdate) here.
end