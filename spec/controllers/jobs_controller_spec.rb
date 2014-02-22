require_relative '../spec_helper'

describe JobsController do
  context '#create' do
  
    it 'creates a job from params' do
      expect{
        post :create, job: {title: "Janitor"}
      }.to change{Jobs.count}.by(1)
    end
  end
end