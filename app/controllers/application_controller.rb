class ApplicationController < ActionController::API
  # simple request logging to the db
  before_action :log_request
  after_action :log_response

  protected

  def log_request
    @apilog = ApiLog.create(
      ip: request.ip,
      request_uri: request.url,
      request_method: request.method,
      request_body: request.body.read,
      request_params: request.params.to_json
    )
  end

  def log_response
    return unless @apilog.present?

    @apilog.update(
      response_body: response.body,
      response_status_code: response.status
    )
  end
end
