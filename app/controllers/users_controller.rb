class UsersController < ApplicationController

  def uploads
    file = params["user"]["name"].tempfile.path
    ParseLibrary.new().add_library_to_db(file)
    redirect_to songs_path
  end

  def show
    @songs = Song.all
    @users = User.all
  end

end
