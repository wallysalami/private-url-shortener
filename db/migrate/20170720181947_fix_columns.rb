class FixColumns < ActiveRecord::Migration[5.1]
  def change
    change_column_null :users, :email, false, ''
    change_column_null :users, :name, false, ''
    change_column_null :users, :password_digest, false, ''
    change_column_null :shortened_urls, :user_id, false, ''
    change_column_null :shortened_urls, :short_uri, false, ''
    change_column_null :shortened_urls, :destination_url, false, ''

    add_index :users, :email, unique: true
    add_index :shortened_urls, :short_uri

    rename_column :users, :email, :username
    rename_column :users, :name, :full_name
  end
end