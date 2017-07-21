class CreateShortenedUrlAccesses < ActiveRecord::Migration[5.1]
  def change
    create_table :shortened_url_accesses do |t|
      t.references :shortened_url, foreign_key: true, null: false
      t.string :ip, null: false
      t.string :referer
      t.string :country_name
      t.string :region_code
      t.string :region_name
      t.string :city
      t.string :time_zone
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
