class HomeController < ApplicationController

  before_action :authenticate_user!

  def index
    @hotels = Hotel.all
  end
end
