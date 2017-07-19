class CreateShortenedUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :shortened_urls do |t|
      t.references :user, foreign_key: true
      t.string :short_uri
      t.string :destination_url

      t.timestamps
    end
  end
end
