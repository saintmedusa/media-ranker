class UsersController < ApplicationController
  before_action :find_user, only: [:show]

  def index
    @users = User.all
  end

  def show; end

  def login_form
    @user = User.new
  end

  def login # dry up
    @user = User.find_by(username: params[:username])
    if @user.nil?
      @user = User.new(user_params)
      if @user.save
        session[:current_user_id] = @user.id
        flash[:success] = "Created new account. Welcome, #{params[:username]}"
        redirect_to user_path(@user)
        return
      else 
        flash.now[:error] = "User wasn't created, try a different username"
        render :new, status: :bad_request
        return
      end
    else
      session[:current_user_id] = @user.id
      flash[:success] = "Welcome back, #{@user.username}"
      redirect_to root_path
    end
  end


  private
  def user_params
    return params.require(:user).permit(:username)
  end

  def find_user
    @user = User.find_by(id: params[:id])
    if @user.nil?
      head :not_found
      return
    end
  end

end