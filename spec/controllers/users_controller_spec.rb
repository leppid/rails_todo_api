require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#create' do
    it 'checks factory validation' do
      build(:user).should be_valid
    end

    it 'returns a bad response' do
      post :create, params: { user: attributes_for(:user, password: "password1233") }
      expect(response).to_not be_success
    end

    it 'checks email exists' do
      post :create, params: { user: attributes_for(:user) }
      expect(response).to be_success
      post :create, params: { user: attributes_for(:user) }
      expect(response).to_not be_success
    end

    it 'returns a successful response' do
      post :create, params: { user: attributes_for(:user) }
      expect(response).to be_success
    end
  end

  describe '#confirmemail' do
    it 'should search activaiton_digest' do
      @user = create(:user)
      expect(response).to be_success
      post :confirmemail, params: { user: @user.activation_digest }
      expect(response).to be_success
    end
  end
end
