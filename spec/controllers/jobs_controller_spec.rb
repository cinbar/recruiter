require_relative '../spec_helper'

describe JobsController do
  context '#create' do
    describe 'success' do
      it 'creates a job from params' do
        expect{
          post :create, job: {title: "Janitor"}
        }.to change{Job.count}.by(1)
      end
    end
    
    describe 'failure' do
      before(:each) do
        Job.any_instance.stub(:save).and_return(false)
      end
    
      it 'creates a job from params' do
        expect{
          post :create, job: {title: "Janitor"}
        }.to change{Job.count}.by(0)
      end
    end
  end
end