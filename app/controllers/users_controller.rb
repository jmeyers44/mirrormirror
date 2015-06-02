class UsersController < ApplicationController

  def show
    @songs = Song.all
    @users = User.all
  end

end
