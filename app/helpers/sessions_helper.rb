module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def remember_token_stored
    request.headers["Authentication"] || User.encrypt(cookies[:remember_token]) 
  end

  def current_user
    @current_user ||= User.find_by_remember_token(remember_token_stored)
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      respond_to do |format|
        format.html {
          store_location
          redirect_to signin_url         
        }
        format.json {
          render json: { status: 'error', message: 'Not authorized' }
        }
      end
    end
  end

  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
    user = User.find_by_remember_token(remember_token) 
    if user 
      remember_token = User.new_remember_token
      user.update_attribute(:remember_token, remember_token)
    end
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end
end