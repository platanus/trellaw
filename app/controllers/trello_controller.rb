class TrelloController < ApplicationController
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

    # TODO: store access token and secret in user

    render html: "#{access_token.token} - #{access_token.secret}"
  end

  private

  def consumer
    TrelloClient.oauth_consumer
  end
end
