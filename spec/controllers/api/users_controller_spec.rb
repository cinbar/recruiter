require 'spec_helper'

describe Api::UsersController do
  # context '#create' do
  #   describe 'success' do
  #     it 'creates a job from params' do
  #       expect{
  #         post :create, job: {title: "Janitor"}
  #       }.to change{Job.count}.by(1)
  #     end
  #   end
    
  #   describe 'failure' do
  #     before(:each) do
  #       Job.any_instance.stub(:save).and_return(false)
  #     end
    
  #     it 'creates a job from params' do
  #       expect{
  #         post :create, job: {title: "Janitor"}
  #       }.to change{Job.count}.by(0)
  #     end
  #   end
  # end

  context '#show' do
   describe 'existing user' do
    let(:user){FactoryGirl.create :user}

      before(:each) do
        user.id = 1
      end

      it 'returns an existing user' do
        get :show, id: 1
        response.should eq(user.to_json)
      end
   end

  end
end