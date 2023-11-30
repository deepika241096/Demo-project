class WebhookJob < ApplicationJob
  queue_as :default

  def perform(endpoint_url, payload, auth_token)
    response = HTTParty.post(endpoint_url, 
                             body: payload.to_json, 
                             headers: { 'Content-Type' => 'application/json',
                                      'Authorization' => "Bearer #{auth_token}" })
    
    if response.code == 200
      Rails.logger.info('Webhook call successful!')
    else
      Rails.logger.error("Webhook call failed with status code: #{response.code}")
    end
    rescue => e
      Rails.logger.error("Error sending webhook: #{e.message}")
  end
end
