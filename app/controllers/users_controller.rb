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

  def play
    youtube_base_url = "https://www.googleapis.com/youtube/v3/search?part=snippet&q="
    api_key = ENV['YOUTUBE_API']
    song = Song.find(params[:id])
    query = song.name.gsub!(/[^0-9A-Za-z ]/,'').split.join("+")

    uri = URI(youtube_base_url+query+"&key="+api_key)
    binding.pry
    result = Net::HTTP.get(uri)
    # response = HTTParty.get(youtube_base_url+query+"&key="+api_key)
    @youtube_id = result["items"][0]["id"]["videoId"]
    respond_to do |format|
      format.js
    end
  end

end
