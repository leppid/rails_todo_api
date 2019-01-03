require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe '#create' do
    it 'checks factory validation' do
      build(:user).should be_valid
    end

    it 'returns a successful response' do
      @user = create(:user)
      post :create, params: { session: attributes_for(:user, :login) }
      expect(response).to_not be_success
      @user.activate
      post :create, params: { session: attributes_for(:user, :login) }
      expect(response).to be_success
    end

    it 'checks password' do
      @user = create(:user)
      post :create, params: { session: attributes_for(:user, :login, password: "password1244") }
      expect(response).to_not be_success
    end

    it 'checks user exists' do
      @user = create(:user)
      post :create, params: { session: attributes_for(:user, :login, email: "testoo@gmail.com") }
      expect(response).to_not be_success
    end
  end
end
