class Api::BaseController < ApplicationController
  include Api::Error
  include Api::Versioned
  include Api::Deprecated
  include Api::Paged

  self.responder = ApiResponder

  protect_from_forgery with: :null_session
  respond_to :json
end
