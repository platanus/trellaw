class Api::V1::ViolationsController < Api::V1::BaseController

  def index
    @violations = Violation.active.where(card_tid: params[:card_id])

    respond_with @violations
  end
end
