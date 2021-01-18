class UsersController < ApplicationController
  before_action :authenticate_user,{only: [:index,:show,:edit,:update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}

  def index
  end

  def new
  @user = User.new
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password]
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end

  def login_form
  
  end

  def login
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/posts/index")
    else
      @error_message ="名前またはパスワードが間違っています"
      
      @name = params[:name]
      @password = params[:password]
      render("users/login_form")
    end
  end

   def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end
end
