require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe '#create' do
    before do
      user = create(:user)
      allow_any_instance_of(TasksController).to receive(:current_user).and_return(user)
    end

    it 'checks factory validation' do
      build(:task).should be_valid
    end

    it 'create new task' do
      post :create, params: { task: attributes_for(:task) }
      expect(response).to be_success
    end

    it 'should render task' do
      get :index
    end

    it 'should show task profile' do
      post :create, params: { task: attributes_for(:task) }
      post :show, params: { id: "1" }
      expect(response).to be_success
    end

    it 'should update task' do
      post :create, params: { task: attributes_for(:task) }
      get :update, params: { id: "1", task: attributes_for(:task, title: "Task123") }
      expect(response).to be_success
    end

    it 'should delete task' do
      post :create, params: { task: attributes_for(:task) }
      post :destroy, params: { id: "1" }
    end

    it 'should delete tasks' do
      post :create, params: { task: attributes_for(:task) }
      post :create, params: { task: attributes_for(:task, id: "2") }
      post :destroychecked, params: { ids: "1, 2" }
      expect(response).to be_success
      post :destroychecked, params: { ids: "" }
    end
  end
end
