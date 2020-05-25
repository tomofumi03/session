class SessionsController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.find_by(user_params)
    if @user && @user.authenticate(user_params)
      log_in user
      redirect_to root_path, success: 'ログインに成功しました'
    else
      flash.now[:dander] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url, info: 'ログアウトしました'
  end

  private
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
