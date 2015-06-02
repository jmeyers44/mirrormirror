class Song < ActiveRecord::Base
  belongs_to :album
  has_many :song_tags
  has_many :tags, through: :song_tags
  has_many :user_songs
  has_many :users, through: :user_songs
end
