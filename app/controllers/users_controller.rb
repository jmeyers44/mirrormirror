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

    song = Song.find(params[:id])
    
    if song.links.empty?

      youtube_base_url = "https://www.googleapis.com/youtube/v3/search?part=snippet&q="
      api_key = ENV['YOUTUBE_API']
      query = song.name.gsub(/[^0-9A-Za-z ]/,'').split.join("+")

      uri = URI(youtube_base_url+query+"&key="+api_key)
      result = Net::HTTP.get(uri)

      # response = HTTParty.get(youtube_base_url+query+"&key="+api_key)
      
      json_result = JSON.load(result)
      youtube_video_base_url = "https://www.youtube.com/watch?v="
      url_array = []
      
      json_result["items"].each do |youtube_vid|
        formatted_url = youtube_video_base_url+youtube_vid["id"]["videoId"]
        url_array << formatted_url
        song.links << Link.create(url: formatted_url, accuracy_rating: 0)
      end
      
      @url = url_array[0]

    else
      @url = song.links.order(accuracy_rating: :desc).limit(1)
    end
    respond_to do |format|
      format.js
    end
  end

end
