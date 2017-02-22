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

  def get_member_tid
    @client.find('members', 'me').id
  end

  def board_member?(_board_tid, _member_tid)
    get_board_member_ids(_board_tid).any? { |m_id| m_id == _member_tid }
  end

  def add_board_member(_board_tid, _member_tid, type: :normal)
    board = build_object(Trello::Board, _board_tid)
    member = OpenStruct.new id: _member_tid
    board.add_member(member, type)
  end

  def add_board_webhook(_board_tid, _callback_url)
    webhook = @client.create(
      :webhook,
      description: 'Trellaw hook',
      callback_url: _callback_url,
      id_model: _board_tid
    )

    TrelloWebhook.new.tap { |tw| tw.tid = webhook.id }
  end

  def delete_webhook(_webhook_tid)
    webhook = @client.find(:webhook, _webhook_tid)
    webhook.delete
  end

  def get_own_boards
    boards = @client.find_many(Trello::Board, '/members/me/boards?filter=open')
    boards.map do |board|
      TrelloBoard.new.tap do |trello_board|
        trello_board.tid = board.id
        trello_board.name = board.name
        trello_board.description = board.description
      end
    end
  end

  def get_board(_board_tid)
    board = @client.find(:board, _board_tid)

    TrelloBoard.new.tap do |trello_board|
      trello_board.tid = board.id
      trello_board.name = board.name
      trello_board.description = board.description
    end
  end

  def get_lists(_board_tid)
    lists = @client.find_many(Trello::List, "/boards/#{_board_tid}/lists?filter=open")
    lists.map do |list|
      TrelloList.new.tap do |trello_list|
        trello_list.tid = list.id
        trello_list.name = list.name
      end
    end
  end

  private

  def get_board_member_ids(_board_tid)
    board = build_object(Trello::Board, _board_tid)
    board.members.map &:id
  end

  def build_object(_type, _id = nil)
    _type.new(id: _id).tap { |obj| obj.client = @client }
  end
end
