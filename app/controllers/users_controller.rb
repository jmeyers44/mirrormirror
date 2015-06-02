class UsersController < ApplicationController

  def show
    @songs = Song.all
    # @artist = Song.find_by(artist_id)
    # @album = Song.find_by(album_id)
  end

end
