require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = FactoryBot.build(:user) # Create a User instance using the factory before each example
  end

  it '正しい属性であれば有効であること' do
    expect(@user).to be_valid
  end

  it 'ニックネームがなければ無効であること' do
    @user.nickname = nil
    @user.valid?
    expect(@user.errors.full_messages).to include("Nickname can't be blank")
  end

  it '有効なメールアドレスでなければ無効であること' do
    @user.email = 'invalid_email'
    @user.valid?
    expect(@user.errors.full_messages).to include('Email is invalid')
  end

  it '重複したemailが存在する場合は登録できない' do
    @user.save
    another_user = FactoryBot.build(:user)
    another_user.email = @user.email
    another_user.valid?
    expect(another_user.errors.full_messages).to include('Email has already been taken')
  end

  it 'メールアドレスに@が含まれなければ無効であること' do
    @user.email = 'testmail'
    @user.valid?
    expect(@user.errors.full_messages).to include('Email is invalid')
  end

  it 'パスワードが5文字以下であれば無効であること' do
    user = FactoryBot.build(:user, password: '12345', password_confirmation: '12345')
    user.valid?
    expect(user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
  end

  it 'パスワードが129文字以上であれば無効であること' do
    user = FactoryBot.build(:user, password: 'a' * 129, password_confirmation: 'a' * 129)
    user.valid?
    expect(user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
  end
end
