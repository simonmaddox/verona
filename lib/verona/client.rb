require 'json'
require 'net/https'
require 'uri'

module Verona
  class Client

    def initialize
      refresh_access_token
    end

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
      request['Authorization'] = "Bearer #{@current_access_token}"

      response = http.request(request)

      if response.class.eql? Net::HTTPUnauthorized
        refresh_access_token
        json_response_from_verifying_token(attributes)
      else
        JSON.parse(response.body)
      end
    end

      def refresh_access_token
        uri = URI("https://accounts.google.com/o/oauth2/token")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER

        request = Net::HTTP::Post.new(uri.request_uri)
        request.set_form_data(
            {
              "grant_type" => "refresh_token",
              "refresh_token" => ENV['GOOGLE_PLAY_REFRESH_TOKEN'],
              "client_id" => ENV['GOOGLE_PLAY_CLIENT_ID'],
              "client_secret" => ENV['GOOGLE_PLAY_CLIENT_SECRET'],
            })
        response = http.request(request)
        json = JSON.parse(response.body)

        @current_access_token = json['access_token'] if json['access_token']
      end

  end
end