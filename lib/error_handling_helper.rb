# -*- encoding : utf-8 -*-
# All methods are pretty simple and don't need tests and docs
module ErrorHandlingHelper
  def do_redirect_for(error, options={})
    target = root_url
    if error.instance_of? NextdoorzErrors::RenderedError
      target = self.send(error.redirection_method_name)
    elsif request.env["HTTP_REFERER"]
      target = :back
    end
    redirect_to target
  end

  def render_error_message(message, options={})
    hash = {json: {status: "error", message: message}}.merge! options
    render hash
  end

  def status_for_error(error)
    return error.state if error.is_a? NextdoorzErrors::RenderedError
    return 404 if error.is_a? ActiveRecord::RecordNotFound
    500
  end

  def log_write(error)
    Rails.logger.error error.inspect
    error.backtrace.first(5).each do |line|
      Rails.logger.error line
    end
  end
end
