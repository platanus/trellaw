class Api::BaseController < ApplicationController
  include Api::Error
  include Api::Versioned
  include Api::Deprecated
  include Api::Paged

  self.responder = ApiResponder

  respond_to :json
end
