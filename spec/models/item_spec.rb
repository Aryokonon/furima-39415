RSpec.describe 'Items', type: :request do
  describe 'GET /index' do
    context 'ログインユーザーの場合' do
      before do
        @user = FactoryBot.create(:user)
        sign_in @user
      end

      it '/indexにアクセス可能' do
        get '/items/index'
        expect(response).to have_http_status(:ok)
      end

      it '商品出品ページに遷移可能' do
        get '/items/new'
        expect(response).to have_http_status(:ok)
      end

      # ログインユーザーに対する他のテスト
    end

    context 'ログアウトユーザーの場合' do
      it '/indexへのアクセスがログインページへリダイレクトされる' do
        get '/items/index'
        expect(response).to redirect_to(new_user_session_path)
      end

      it '商品出品ページへのアクセスがログインページへリダイレクトされる' do
        get '/items/new'
        expect(response).to redirect_to(new_user_session_path)
      end

      # ログアウトユーザーに対する他のテスト
    end

    context '有効な商品データを送信した場合' do
      before do
        @user = FactoryBot.create(:user)
        sign_in @user
      end

      it '商品情報がデータベースに保存され、トップページにリダイレクトされる' do
        item_attributes = FactoryBot.attributes_for(:item)
        expect do
          post '/items', params: { item: item_attributes }
        end.to change(Item, :count).by(1)

        expect(response).to redirect_to(root_path)
      end

      # 有効なデータ送信に対する他のテスト
    end

    context '無効な商品データを送信した場合' do
      before do
        @user = FactoryBot.create(:user)
        sign_in @user
      end

      it '商品情報がデータベースに保存されず、新規作成テンプレートがレンダリングされる' do
        post '/items', params: { item: FactoryBot.attributes_for(:item, name: nil) }
        expect(response).to render_template(:new)
        expect(assigns(:item).name).to be_nil
      end

      # 無効なデータ送信に対する他のテスト
    end
  end
end
