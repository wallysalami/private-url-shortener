class ShortenedUrlAccess < ApplicationRecord
  belongs_to :shortened_url

  def self.register_access(request, shortened_url)
    # if a browser is prefetching the url, do not count it as an access!
    if request.headers['X-Purpose'] == 'preview' || request.headers['X-moz'] == 'prefetch'
      return
    end

    access = ShortenedUrlAccess.new
    access.shortened_url_id = shortened_url.id
    access.ip = request.remote_ip
    access.referer = request.referer
    access.save

    begin
      url = 'https://freegeoip.net/json/' + request.remote_ip
      geo_data = JSON.parse(open(url).read)

      access.save_geodata_values(geo_data)
    rescue SocketError, JSON::ParserError => e
      puts "error loading IP location: #{e.message}"
    end
  end

  def save_geodata_values(geo_data)
    fields = ['country_name', 'region_code', 'region_name', 'city', 
      'time_zone', 'latitude', 'longitude']

    fields.each do |field|
      if geo_data[field] != '' && geo_data[field] != 0
        self.send("#{field}=", geo_data[field])
      end
    end

    save
  end

  def self.group_by_date(accesses)
    grouped_accesses = []
    previous_date = nil
    accesses.each do |access|
      if access.created_at.to_date != previous_date
        previous_date = access.created_at.to_date
        grouped_accesses.push(
          {:date => previous_date, :accesses => []}
        )
      end
      
      grouped_accesses[-1][:accesses].push(access)
    end

    grouped_accesses
  end

  def full_location
    location = '';
    if country_name != nil
      location = country_name;
    end

    if region_code != nil
      if country_name != nil
        location = ' – ' + location;
      end
      location = region_code + location;
    end

    if city != nil
      if region_code != nil
        location = ', ' + location;
      elsif country_name != nil
        location = ' – ' + location;
      end
      location = city + location;
    end

    location
  end
end
