class Song < ActiveRecord::Base
    belongs_to :user
    has_many :users, through: :playlists
    has_many :playlists

    validates :title, :artist, presence: true, length: { minimum: 2 }
end
