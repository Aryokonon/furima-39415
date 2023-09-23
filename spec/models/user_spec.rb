require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = FactoryBot.build(:user) # Create a User instance using the factory before each example
  end

  context 'ユーザ登録が成功する場合' do
    it '正しい属性であれば有効であること' do
      expect(@user).to be_valid
    end
  end

  context 'ユーザ登録に失敗する場合' do
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

    it 'メールアドレスが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'パスワードが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it '英字のみのパスワードでは登録できない' do
      @user.password = 'abcdef'
      @user.password_confirmation = 'abcdef'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password must include at least one numeric character')
    end

    it '数字のみのパスワードでは登録できない' do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password must include at least one letter character')
    end

    it '全角文字を含むパスワードでは登録できない' do
      @user.password = 'パスワード123'
      @user.password_confirmation = 'パスワード123'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password must include only half-width alphanumeric characters')
    end

    it 'パスワードとパスワード（確認用）が不一致だと登録できない' do
      @user.password_confirmation = 'mismatched_password'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it '姓（全角）が空だと登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it '姓（全角）に半角文字が含まれていると登録できない' do
      @user.last_name = 'Yamada1'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name must include only full-width characters')
    end

    it '名（全角）が空だと登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it '名（全角）に半角文字が含まれていると登録できない' do
      @user.first_name = 'Taro2'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name must include only full-width characters')
    end

    it '姓（カナ）が空だと登録できない' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it '姓（カナ）にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない' do
      @user.last_name_kana = 'やまだ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana must include only katakana characters')
    end

    it '名（カナ）が空だと登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    it '名（カナ）にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない' do
      @user.first_name_kana = 'たろう'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana must include only katakana characters')
    end

    it '生年月日が空だと登録できない' do
      @user.birthdate = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthdate can't be blank")
    end
  end
end
