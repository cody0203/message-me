class UsersController < ApplicationController
  before_action :logged_in_redirect
  def new; end

  def create
    @user = User.new(params.require(:user).permit(:username, :password))
    if @user.save
      flash[:success] = 'Sign up successfully!'
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash.now[:error] = @user.errors.full_messages
      render :new
    end
  end
end
