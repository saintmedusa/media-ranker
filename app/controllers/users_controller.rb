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
    puts params # when I delete this line, this action stops working. IDFK.
    username = params[:username]
    user = User.find_by(username: username)
    if user.nil?
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
    else
      session[:current_user_id] = user.id
      flash[:success] = "Welcome back, #{user.username}"
      redirect_to root_path
      return
    end
  end

  # def login
  #   username = params[:user][:username]
  #   user = User.find_by(username: username)
  #   if user
  #     session[:user_id] = user.id
  #     flash[:success] = "Successfully logged in as returning user #{username}"
  #   else
  #     user = User.create(username: username)
  #     session[:user_id] = user.id
  #     flash[:success] = "Successfully logged in as new user #{username}"
  #   end
  
  #   redirect_to root_path
  #   return
  # end

  def current
    @current_user = User.find_by(id: session[:current_user_id])
    if @current_user.nil?
      flash[:error] = "Please login:"
      redirect_to login_path
    end
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