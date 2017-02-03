module TrelloUtils
  extend self

  HAM_TRELLO_KEY = ENV['HAM_TRELLO_KEY'].freeze
  HAM_TRELLO_TOKEN = ENV['HAM_TRELLO_TOKEN'].freeze

  def summon_the_monkey
    TrelloClient.from_member_token(
      api_key: HAM_TRELLO_KEY,
      member_token: HAM_TRELLO_TOKEN
    )
  end

  def load_user_client(_user)
    TrelloClient.from_oauth(
      access_token: _user.trello_access_token,
      access_secret: _user.trello_access_secret
    )
  end
end
