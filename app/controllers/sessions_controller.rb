class SessionsController < ApplicationController
  before_action :loggedIn , only: [:destroy]
  
  def new
      # render login page
  end
  def create

      @user = User.find_by_email(params[:email].downcase).try(:authenticate, params[:password])
      unless @user
        flash[:errors] = ["Invalid combination"]
        redirect_to "/users/new"
      else
        session[:user_id] = @user.id
        redirect_to "/songs"
      end


      

  end
  def destroy
      # Log User out
      # set session[:user_id] to null
      # redirect to login page
      session[:user_id] = nil
      redirect_to "/users/new"
  end



end