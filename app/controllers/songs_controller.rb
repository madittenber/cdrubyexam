class SongsController < ApplicationController
  before_action :loggedIn , only: [:playlistadd, :create]

  def index

      @songs = Song.all.order(:artist, :title)
  end

  
  def create

    @songs = Song.create( title: params[:title], artist: params[:artist], user_id: current_user.id)

    if @songs.errors.any?  # this is not a built-in method. Assume that errors? returns true if something is wrong!
      flash[:errors] = @songs.errors.full_messages
      redirect_to '/songs' #pathing will be explained later
      # render plain: flash[:error]
    else
      flash[:success] = ["New Song"]
      redirect_to '/songs'
    end

  end

  def playlistadd
    
      Playlist.create(song: Song.find(params[:songid]), user: current_user)
      redirect_to '/songs'
  end

  def show

    if Song.find_by_id(params[:songid])
      @song = Song.find(params[:songid])
      @users = User.all.order(:firstName)
    else
      redirect_to '/songs'
    end

  end


end
