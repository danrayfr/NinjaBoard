class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    flash.now[:success] = {
      title: 'Successfully sign up',
      body: 'welcome to our application'
    }
  end
end
