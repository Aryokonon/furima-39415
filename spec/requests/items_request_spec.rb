require 'rails_helper'

RSpec.describe 'Items', type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) do
    {
      name: 'Sample Item',
      description: 'This is a sample item.',
      category_id: 2, # Assuming 2 is a valid category
      condition_id: 2,
      delivery_fee_id: 2,
      prefecture_id: 2,
      shipping_day_id: 2,
      price: 500,
      image: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'sample.jpg'), 'image/jpg')
    }
  end

  describe 'POST /create' do
    context 'when not logged in' do
      it 'redirects to the login page' do
        post items_path, params: { item: valid_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when logged in' do
      before do
        sign_in user
      end

      context 'with valid parameters' do
        it 'creates a new item' do
          expect do
            post items_path, params: { item: valid_attributes }
          end.to change(Item, :count).by(1)
        end

        it 'redirects to the root path' do
          post items_path, params: { item: valid_attributes }
          expect(response).to redirect_to(root_path)
        end
      end

      context 'with invalid parameters' do
        let(:invalid_attributes) { valid_attributes.merge(name: '') }

        it 'does not create a new item' do
          expect do
            post items_path, params: { item: invalid_attributes }
          end.not_to change(Item, :count)
        end

        it "renders the 'new' template" do
          post items_path, params: { item: invalid_attributes }
          expect(response).to render_template(:new)
        end
      end
    end
  end
end
