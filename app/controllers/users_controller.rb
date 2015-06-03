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
    render action: :loading
  end

  def show
    @songs = Song.all
    @user = User.find(params[:id])
  end

  def parse
    ParseLibrary.new().add_library_to_db(params[:file_path], current_user)
    @songs = Song.all
    @users = User.all
    redirect_to user_path(current_user.id)
  end

  def loading
  end

end
