class UsersController < ApplicationController
# before_action :authenticate_user!

  def uploads
    user_file = params["user"]["name"].tempfile.path
    file = "#{Rails.root}/tmp/#{current_user}"
    open(file, 'wb') do |file|
      file.write open(user_file).read 
    end 
    @file = file
    # @songs = Song.all
    # @users = User.all
    render action: :loading
  end

  def show
    @songs = current_user.songs
    @user = current_user
    @song_array = @songs.collect do |song|
    # binding.pry

      hash = {}
      query = song.query_as(:s).match("s<-[r1]-(album:Album)<-[r2]-(artist:Artist)").pluck(:album, :artist).uniq
      # hash[:play_count] = 
      hash[:song_id] = song.id
      hash[:song_name] = song.name
      hash[:album_name] = query[0][0].name
      hash[:artist_name] = query[0][1].name
      hash
    end

    @partial = "songs"
  end

  def parse
    ParseLibrary.new().add_library_to_db(params[:file_path], current_user)
    # @songs = Song.all
    # @users = User.all
    redirect_to user_path(current_user.id)
  end

  def loading
  end

  def recommended
    recommendation_selectivity = 0.005
    total_play_count = current_user.total_plays
    play_threshold = total_play_count * recommendation_selectivity
    # binding.pry
    @songs_users = current_user.query_as(:u).match("u-[r1:has_song]->(s1:Song)<-[r2:has_song]-(u2:User)-[r3:has_song]->(s2:Song)").where("r3.play_count > u2.total_plays*#{recommendation_selectivity} AND u <> u2 AND r1.play_count > #{play_threshold} AND NOT (u)-->(s2)").pluck(:s2, :u2).uniq
    @partial = "recommendations"
    render :show
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
        if youtube_vid["id"]["videoId"]
          formatted_url = youtube_video_base_url+youtube_vid["id"]["videoId"]
          url_array << formatted_url

          @link = Link.create(url: formatted_url, accuracy_rating: 0)
          song.links << @link
          end
        end
      
    else
      @link = song.links.order(accuracy_rating: :desc).limit(1).first

    end
    links_array = song.links.order(accuracy_rating: :desc).limit(5).to_a
    
    @links_array_hash = links_array.collect do |link|
      {link.id.to_s => link.url}
    end

    user_song_rel = current_user.songs.first_rel_to(song.id)
    current_play_count = user_song_rel.play_count
    @play_count = current_play_count + 1
    user_song_rel.update(play_count: @play_count)


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

  def loading_recommendations
  end

end
