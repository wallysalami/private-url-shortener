class FixDeleteCascade < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :shortened_urls, :users
    add_foreign_key :shortened_urls, :users, on_delete: :cascade

    remove_foreign_key :shortened_url_accesses, :shortened_urls
    add_foreign_key :shortened_url_accesses, :shortened_urls, on_delete: :cascade
  end
end
