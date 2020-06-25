class UsersController < ApplicationController
  before_action :loggedIn , only: [:show, :edit, :update, :destroy]

  def new
    
  end

  def create

    @user = User.create( firstName: params[:firstName], lastName: params[:lastName], email: params[:email], password: params[:password], password_confirmation: params[:passwordConf])

    
    if @user.errors.any?  # this is not a built-in method. Assume that errors? returns true if something is wrong!
      flash[:errors] = @user.errors.full_messages
      redirect_to '/users/new' #pathing will be explained later
      # render plain: flash[:error]
    else
      flash[:success] = "You did it!"
      redirect_to '/users/new'
    end

    
  end

  def show
    # session[:user_id] = 3
    @user = User.find(params[:id])
    @songs = Song.all.order(:artist, :title)
    render "show"

  end

  def edit
    @user = User.find(params[:id])
    render "edit"
  end

  def update
    @user = User.find(params[:id])
    @user.firstName = params[:firstName]
    @user.lastName = params[:lastName]
    @user.email = params[:email]
    @user.save
    
    if @user.errors.any?  # this is not a built-in method. Assume that errors? returns true if something is wrong!
      flash[:errors] = @user.errors.full_messages
      redirect_to '/users/'+params[:id]+'/edit' #pathing will be explained later
      # render plain: flash[:error]
    else
      flash[:success] = "You did it!"
      redirect_to '/users/'+params[:id]
    end

  end
  def destroy
    session[:user_id] = nil
    user = User.find(params[:id]).destroy

    redirect_to 'sessions'
  end
    

  def playlist
      # if User.find_by_id(params[:id])
        @user = User.find(params[:id])
        # @User.find(params[:id]).playlists
        # User.find(params[:id]).playlists.group(:song_id).count WTF?

        @songs = Song.all.order(:artist, :title)
        
  end

    private

      def user_params
        params.require(:user).permit(:firstName, :lastName, :email, :password)
      end

end
