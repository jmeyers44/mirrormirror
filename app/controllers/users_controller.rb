class UsersController < ApplicationController

  def uploads
    user_file = params["user"]["name"].tempfile.path
    file = "#{Rails.root}/tmp/#{current_user}"
    open(file, 'wb') do |file|
      file.write open(user_file).read 
    end
    redirect_to songs_path
    ParseLibrary.new().add_library_to_db(file, current_user)
  end

  def show
    @songs = Song.all
    @users = User.all
  end

end
