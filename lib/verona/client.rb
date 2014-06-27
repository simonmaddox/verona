require 'json'
require 'net/https'
require 'uri'

module Verona
  class Client
    def verify!(attributes = {}, options)
      json = json_response_from_verifying_token(attributes)
      error = json['error'] if json['error']
      if !error and json
        Receipt.new(json.merge(attributes)) 
      else 
        false 
      end
    end

    private

    def json_response_from_verifying_token(attributes = {})
      uri = URI("https://www.googleapis.com/androidpublisher/v1.1/applications/#{attributes[:package_name]}/inapp/#{attributes[:product_id]}/purchases/#{attributes[:token]}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER

      request = Net::HTTP::Get.new(uri.request_uri)
      request['Accept'] = "application/json"
      request['Content-Type'] = "application/json"
      request['Authorization'] = "Bearer #{ENV['GOOGLE_PLAY_ACCESS_TOKEN']}"

      response = http.request(request)

      JSON.parse(response.body)
    end
  end
end