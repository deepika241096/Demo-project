class UsersController < ApplicationController
	skip_before_action :verify_authenticity_token

	def create
		user = User.new(permit_params)

		if user.save
			WebhookJob.perform_now(WebhookEndpointService.endpoint_url, user.as_json, user.description)
			render json: user
		end
	end

	def update
		user_data = User.find_by(id: params[:id])

		if user_data
			WebhookJob.perform_now(WebhookEndpointService.endpoint_url, user_data.as_json, user_data.description)

			user_data.update(permit_params)
			render json: user_data
		end
	end

	private

	def permit_params
		params.permit(:name, :description, :phone_number)
	end

end

