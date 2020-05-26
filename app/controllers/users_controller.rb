class UsersController < ApplicationController
  skip_before_action :require_login, except: [:logout, :current]
  before_action :find_user, only: [:show]

  def index
    @users = User.all
  end

  def show; end

  def login_form
    if session[:current_user_id] != nil
      flash[:error] = "You must logout before doing that."
      redirect_to root_path
      return
    end
  end

  def login
    username = params[:username]
    user = User.find_by(username: username)
    if !user.nil?
      session[:current_user_id] = user.id
      flash[:success] = "Welcome back, #{user.username}"
      redirect_to root_path
      return
    else
      user = User.new(username: username)
      if user.save
        session[:current_user_id] = user.id
        flash[:success] = "Created new account. Welcome, #{user.username}"
        redirect_to current_user_path(user)
        return
      else 
        flash.now[:error] = "User wasn't created, try a different username"
        render :login_form, status: :bad_request
        return
      end
      
    end
  end

  def current
    @current_user = User.find_by(id: session[:current_user_id])
  end

  def logout
    session[:current_user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end


  private
  #  not working for login...
  # def user_params
  #   return params.require(:user).permit(:username)
  # end

  def find_user
    @user = User.find_by(id: params[:id])
    if @user.nil?
      head :not_found
      return
    end
  end

end