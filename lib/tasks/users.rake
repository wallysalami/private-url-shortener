require 'io/console'
require 'optparse'

namespace :users do
  desc 'Create users'
  task :create => :environment do
    user = User.new()
    
    print 'Full Name: '
    user.full_name = STDIN.gets.strip
    print 'Username: '
    user.username = STDIN.gets.strip
    print 'Password: '
    user.password = STDIN.noecho(&:gets).chomp
    print "\nRepeat Password: "
    user.password_confirmation = STDIN.noecho(&:gets).chomp
    puts ''

    if user.save
      puts "\nUser succefully created!"
    else
      puts "\nUser creation failed!"
      puts user.errors.full_messages
    end
  end

  desc 'Delete users'
  task :delete => :environment do
    # Find user with command line arguments
    user = nil
    if ENV['username'] != nil
      user = User.find_by(:username => ENV['username'])
    elsif ENV['id'] != nil
      user = User.find_by(:id => ENV['id'])
    else
      puts 'Usage: "rake users:delete username=<username>" or "rake users:delete id=<id>".'
      exit 1
    end

    if user != nil
      # Display user information, just to make sure it should be deleted
      puts user.inspect
      puts ''
      
      # Loop until user enters "y" or "n"
      begin
        print 'Are you sure you want to delete this user? (y/n): '
        input = STDIN.gets.strip.downcase
      end until %w(y n).include?(input)

      if input == 'y'
        user.destroy
        puts 'User deleted.'
      else
        puts 'Canceled deletion.'
      end
    else
      puts 'Error! No user was found!'
    end

    exit 0
  end
end