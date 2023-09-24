require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) { attributes_for(:item) }
  let(:invalid_attributes) { attributes_for(:item, name: nil) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'は新しいテンプレートをレンダリングします' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context '有効なパラメータの場合' do
      it 'はデータベースに新しいアイテムを保存します' do
        expect do
          post :create, params: { item: valid_attributes }
        end.to change(Item, :count).by(1)
      end

      it 'はroot_pathにリダイレクトします' do
        post :create, params: { item: valid_attributes }
        expect(response).to redirect_to root_path
      end
    end

    context '無効なパラメータの場合' do
      it 'はデータベースに新しいアイテムを保存しません' do
        expect do
          post :create, params: { item: invalid_attributes }
        end.not_to change(Item, :count)
      end

      it 'は新しいテンプレートを再レンダリングします' do
        post :create, params: { item: invalid_attributes }
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do
    let(:item) { create(:item, user: user) }

    it 'は編集テンプレートをレンダリングします' do
      get :edit, params: { id: item.id }
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    let(:item) { create(:item, user: user) }

    context '有効なパラメータの場合' do
      it 'はデータベースのアイテムを更新します' do
        patch :update, params: { id: item.id, item: valid_attributes }
        item.reload
        expect(item).to have_attributes valid_attributes
      end

      it 'は更新されたアイテムにリダイレクトします' do
        patch :update, params: { id: item.id, item: valid_attributes }
        expect(response).to redirect_to item
      end
    end

    context '無効なパラメータの場合' do
      it 'はアイテムを更新しません' do
        patch :update, params: { id: item.id, item: invalid_attributes }
        item.reload
        expect(item.name).not_to be_nil
      end

      it 'は編集テンプレートを再レンダリングします' do
        patch :update, params: { id: item.id, item: invalid_attributes }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:item) { create(:item, user: user) }

    it 'はデータベースからアイテムを削除します' do
      expect do
        delete :destroy, params: { id: item.id }
      end.to change(Item, :count).by(-1)
    end

    it 'はアイテム一覧にリダイレクトします' do
      delete :destroy, params: { id: item.id }
      expect(response).to redirect_to items_path
    end
  end
end
