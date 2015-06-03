class UsersController < ApplicationController

  def uploads
    user_file = params["user"]["name"].tempfile.path
    file = "#{Rails.root}/tmp/#{current_user}"
    open(file, 'wb') do |file|
      file.write open(user_file).read 
    end 
    @file = file
    @songs = Song.all
    @users = User.all
    render action: :show 
  end

  def show
    @songs = Song.all
    @users = User.all
  end

  def parse
    ParseLibrary.new().add_library_to_db(params[:file_path], current_user)
  end

end
