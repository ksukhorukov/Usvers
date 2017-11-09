class UsersController < ApplicationController
  before_action :signed_in_user,
                only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page])
    respond_to do |format|
      format.html {
        render 'index'
      }
      format.json {
        render json: @users
      }
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html {
        render 'show'
      }
      format.json {
        render json: @user 
      }
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      respond_to do |format|
        format.html { 
          sign_in @user
          flash[:success] = "Welcome to the Usvers!"
          redirect_to @user
        }
        format.json {
          render json: { status: 'ok', message: 'user created' }
        }
      end
    else
      respond_to do |format| 
        format.html {
          render 'new'
        }
        format.json {
          render json: { status: 'error', message: @user.errors }
        }
      end
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      respond_to do |format|
        format.html {
          flash[:success] = "Profile updated"
          sign_in @user
          redirect_to @user          
        }
        format.json {
          render json: @user
        }
      end
    else
      respond_to do |format| 
        format.html {
          render 'edit'
        }
        format.json {
          render json: { status: 'error', message: @user.errors }
        }
      end
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :avatar, :email, :password,
                                   :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user) 
        respond_to do |format|
          format.html {
            redirect_to(root_url)
          }
          format.json {
            render json: { status: 'error', message: 'Anauthroized request' }
          }
        end
      end
    end

end
