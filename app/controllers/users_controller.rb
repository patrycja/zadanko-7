class UsersController < ApplicationController
before_filter :authenticate_user! 
attr_reader :per_page

  def index
    @users = User.paginate(:page => params[:page], :per_page => 15)
  end
  
  def show
    @user = current_user
  end

end
