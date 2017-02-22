class TrelloController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :callback

  def connect
    request_token = consumer.get_request_token(oauth_callback: trello_connected_url)

    session[:token] = request_token.token
    session[:token_secret] = request_token.secret

    redirect_to(
      request_token.authorize_url(oauth_callback: trello_connected_url) + '&scope=read,write'
    )
  end

  def connected
    request_token = OAuth::RequestToken.from_hash(
      consumer,
      oauth_token: session[:token],
      oauth_token_secret: session[:token_secret]
    )

    access_token = request_token.get_access_token oauth_verifier: params[:oauth_verifier]
    current_user.update_attributes!(
      trello_access_token: access_token.token,
      trello_access_secret: access_token.secret
    )

    redirect_to user_root_path
  end

  def callback
    # TODO
    render html: ''
  end

  private

  def consumer
    TrelloClient.oauth_consumer
  end
end
