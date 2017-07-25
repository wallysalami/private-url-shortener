class AddFieldsToShortenedUrls < ActiveRecord::Migration[5.1]
  def change
    add_column :shortened_urls, :title, :string, null: false, :default => ''
    add_column :shortened_urls, :description, :string
    add_column :shortened_urls, :is_locked, :boolean, null: false, :default => false
    add_column :shortened_urls, :show_preview_page, :boolean, null: false, :default => false
  end
end
