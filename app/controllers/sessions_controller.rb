class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      respond_to do |format|
        format.html {
         redirect_back_or user         
        }
        format.json {
          render json: { status: 'ok', authentication: user.remember_token }
        }
      end
    else
      respond_to do |format| 
        format.html {
          flash.now[:error] = 'Invalid email/password combination'
          render 'new'          
        }
        format.json {
          render json: { status: 'error', message: 'Invalid email/password combination' }
        }
      end
    end
  end

  def destroy
    sign_out
    respond_to do |format|
      format.html {
        redirect_to root_url       
      }
      format.json {
        render json: { status: 'ok', message: 'session destroyed' }
      }
    end
  end
end
