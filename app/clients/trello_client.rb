require 'trello'

class TrelloClient
  TRELLO_BASE_URL = "https://trello.com"
  TRELLO_API_KEY = ENV['TRELLO_API_KEY'].freeze
  TRELLO_API_SECRET = ENV['TRELLO_API_SECRET'].freeze
  TRELLO_API_VERSION = 1

  def self.oauth_consumer
    OAuth::Consumer.new(
      TRELLO_API_KEY,
      TRELLO_API_SECRET,
      site: TRELLO_BASE_URL,
      request_token_path: "/#{TRELLO_API_VERSION}/OAuthGetRequestToken",
      authorize_path: "/#{TRELLO_API_VERSION}/OAuthAuthorizeToken",
      access_token_path: "/#{TRELLO_API_VERSION}/OAuthGetAccessToken"
    )
  end

  def self.from_oauth(access_token: nil, access_secret: nil)
    new Trello::Client.new(
      consumer_key: TRELLO_API_KEY,
      consumer_secret: TRELLO_API_SECRET,
      oauth_token: access_token,
      oauth_token_secret: access_secret
    )
  end

  def self.from_member_token(api_key: nil, member_token: nil)
    new Trello::Client.new(
      developer_public_key: api_key,
      member_token: member_token
    )
  end

  def initialize(_client)
    # we could use the oauth client directly:
    # @client = OAuth::AccessToken.from_hash oauth_consumer, oauth_token: x, oauth_token_secret: y
    #
    @client = _client
  end
end
