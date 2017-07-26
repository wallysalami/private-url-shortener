class ShortenedUrl < ApplicationRecord
  belongs_to :user
  has_many :shortened_url_access, -> { order(created_at: :desc) }

  validates :short_uri, :uniqueness => true, :presence => true
  validates :destination_url, :presence => true
  validates_format_of :short_uri, :with => URI::DEFAULT_PARSER.regexp[:REL_URI]
  validates_format_of :destination_url, :with => URI::DEFAULT_PARSER.regexp[:ABS_URI]
  validates :title, :presence => true
  validates :is_locked, inclusion: { in: [ true, false ] }
  validates :show_preview_page, inclusion: { in: [ true, false ] }

  def last_access_date
    first_access = self.shortened_url_access.first
    if first_access != nil
      first_access.created_at
    else
      nil
    end
  end
end
