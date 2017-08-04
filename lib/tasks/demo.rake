require 'io/console'

namespace :demo do
  desc '(Re)Load demonstration data'
  task :reload => :environment do
    user = User.find_by(:username => 'demo')
    if (user == nil)
      user = User.new
      user.full_name = 'Demo User'
      user.username = 'demo'
      user.password = 'demo'
      user.password_confirmation = 'demo'

      if user.save
        puts "Demo user: created."
      else
        puts "Demo user creation failed!"
        puts user.errors.full_messages
        exit 1
      end
    else
      puts 'Demo user already exists.'
    end
    
    ShortenedUrl.where(:user_id => user.id).delete_all
    puts 'Demo urls: deleted.'
    
    url = ShortenedUrl.new(
      :user_id => user.id,
      :title => 'Link with Preview Page',
      :description => 'Shows a preview page with a destination link (to Google, in this case).',
      :short_uri => 'preview',
      :destination_url => 'https://www.google.com',
      :show_preview_page => true
    )
    url.save
    url = ShortenedUrl.new(
      :user_id => user.id,
      :title => 'Locked Link',
      :description => 'Shows a lock screen. Usefull to temporarily prevent access.',
      :short_uri => 'locked',
      :destination_url => 'https://www.apple.com/iphone/',
      :is_locked => true
    )
    url.save
    url = ShortenedUrl.new(
      :user_id => user.id,
      :title => 'Zouk Video',
      :description => 'A couple dancing zouk gracefully. This is a good example to save in a short link, since it is not easily found in a web search.',
      :short_uri => 'zouk',
      :destination_url => 'https://www.youtube.com/watch?v=0fCCCW_3XWI',
    )
    url.save
    url = ShortenedUrl.new(
      :user_id => user.id,
      :title => 'Samba Video',
      :description => 'A couple dancing "samba de gafieira" (real Brazilian samba, not that weird USA thing).',
      :short_uri => 'samba',
      :destination_url => 'https://www.youtube.com/watch?v=0D--wFooyQ8',
    )
    url.save
    puts 'Demo urls: created.'
  end
end