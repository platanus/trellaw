class Api::V1::LawsController < Api::V1::BaseController
  def index
    respond_with LawUtils.active_laws, each_serializer: V1::LawSerializer
  end
end
