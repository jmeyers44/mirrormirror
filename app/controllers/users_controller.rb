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
    artist = song.album.artist
    
    if song.links.empty?

      youtube_base_url = "https://www.googleapis.com/youtube/v3/search?part=snippet&q="
      api_key = ENV['YOUTUBE_API']
      query_artist = artist.name.gsub(/[^0-9A-Za-z ]/,'').split.join("+")
      query_song = song.name.gsub(/[^0-9A-Za-z ]/,'').split.join("+")
      query = query_song + "+" + query_artist
      uri = URI(youtube_base_url+query+"&key="+api_key)
      result = Net::HTTP.get(uri)

      # response = HTTParty.get(youtube_base_url+query+"&key="+api_key)
      
      json_result = JSON.load(result)
      youtube_video_base_url = "https://www.youtube.com/watch?v="
      url_array = []
      
      json_result["items"].each do |youtube_vid|
        formatted_url = youtube_video_base_url+youtube_vid["id"]["videoId"]
        url_array << formatted_url

        @link = Link.create(url: formatted_url, accuracy_rating: 0)
        song.links << @link
      end
      
    else
      @link = song.links.order(accuracy_rating: :desc).limit(1).first

    end

    links_array = Link.where(song_id: song.id).order(accuracy_rating: :desc).limit(5)
    
    @links_array_hash = links_array.collect do |link|
      {link.id.to_s => link.url}
    end

    respond_to do |format|
      format.js
    end
  end

  def accuracy_rating
    current_link = Link.find(params[:id])

    if params[:vote] == "upvote"
      current_link.increment_rating
    elsif params[:vote] == "downvote"
      current_link.decrement_rating
    end

    # links_array = Link.where(song_id: current_link.song.id)

    # @link = links_array.sample

    # respond_to do |format|
    #   format.js
    # end
  end

end
