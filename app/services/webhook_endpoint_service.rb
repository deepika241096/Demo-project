class WebhookEndpointService

  def self.endpoint_url
    Rails.application.config_for(:webhook_endpoints)['endpoint']
  end

end
