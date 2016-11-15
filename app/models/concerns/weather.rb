module Weather
  extend ActiveSupport::Concern

  class_methods do
    def weathers_for_addresses(addresses)
      uri = URI('https://query.yahooapis.com/v1/public/yql')

      addresses_commas = addresses.map{ |address| "'#{ address }'" }.join(',')

      uri.query = URI.encode_www_form(
        q: "select * from weather.forecast where woeid in (select woeid from geo.places(1) where text in (#{ addresses_commas })) and u='c'",
        format: 'json',
        u: 'c'
      )

      # Create client
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER

      # Create Request
      req =  Net::HTTP::Get.new(uri)

      # Fetch Request
      res = http.request(req)
      # Parse JSON into hashes and arrays
      json = JSON.parse(res.body)
      Array.wrap(json.dig('query', 'results', 'channel'))
    rescue StandardError => e
      puts "HTTP Request failed (#{e.message})"
    end
  end
end