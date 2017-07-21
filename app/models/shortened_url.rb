class ShortenedUrl < ApplicationRecord
  belongs_to :user
  validates :short_uri, :uniqueness => true, :presence => true
  validates :destination_url, :presence => true
  validates_format_of :short_uri, :with => URI::DEFAULT_PARSER.regexp[:REL_URI]
  validates_format_of :destination_url, :with => URI::DEFAULT_PARSER.regexp[:ABS_URI] #URI::regexp(%w(http https))
end
