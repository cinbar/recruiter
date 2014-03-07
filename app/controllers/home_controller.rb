class HomeController < ApplicationController
  before_filter :authenticate_user!
  def index
    @current_user ||= current_user
  end
end