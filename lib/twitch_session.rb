require 'yaml'
require 'oauth'
require 'launchy'
require 'singleton'
require 'json'
require 'rest-client'
require 'addressable/uri'

class TwitchSession
  include Singleton
  CONSUMER_KEY = "nf6p0aby5164dtvwceaa3umybz6y3di"
  CONSUMER_SECRET = "8ur0ozhbxjbblzvxzfqa7je9to2zvgi"

  CONSUMER = OAuth::Consumer.new(
    CONSUMER_KEY, CONSUMER_SECRET,
    :site => "https://api.twitch.tv/kraken")

  attr_accessor :access_token

  def initialize
    @access_token = get_token("funtimes.yaml")
  end

  def self.get(*args)
    self.instance.access_token.get(*args).body
  end

  def self.post(*args)
    self.instance.access_token.post(*args).body
  end

  def get_token(token_file)
    # We can serialize token to a file, so that future requests don't need
    # to be reauthorized.

    if File.exist?(token_file)
      File.open(token_file) { |f| YAML.load(f) }
    else
      @access_token = request_access_token
      File.open(token_file, "w") { |f| YAML.dump(access_token, f) }

      @access_token
    end
  end

  def request_access_token
    url = Addressable::URI.new(
          scheme: "https",
          host: "api.twitch.tv",
          path: "/kraken/oauth2/authorize",
          query_values: {
            response_type: "code",
            client_id: "nf6p0aby5164dtvwceaa3umybz6y3di",
            redirect_url: "http://localhost:3000/",
            scope: "user_read"
          }
        )

    return url

    # @request_token = CONSUMER.get_request_token
#     authorize_url = request_token.authorize_url
#
#     session[:request_token] = @request_token
#     redirect_to @request_token.authorize_url
#     #puts "Login, and type your verification code in"
#     #oauth_verifier = gets.chomp
#
#
#     @access_token = @request_token.get_access_token#(oauth_verifier: oauth_verifier)
  end
end