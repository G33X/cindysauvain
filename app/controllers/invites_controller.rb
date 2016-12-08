class InvitesController < ApplicationController

	def create
		@page_title = 'menu.invite'
		@invite = Invite.new message_params
		@locale = I18n.locale

		if @invite.valid? && @invite.email_validation == "true" && params['g-recaptcha-response'].to_s != ''

			send_invite = MessageMailer.send_invite(@invite, request.user_agent)

			if send_invite
				send_invite.deliver
				@status = true
				@status_message = I18n.t("invite.status.invite_delivered")
			else
				@status = false
				@status_message = I18n.t("invite.status.delivery_error")
			end

		else
			@status = false

			if @invite.email_validation != "true"
				@status_message = I18n.t("invite.status.email_error")
			elsif params['g-recaptcha-response'].to_s.empty?
				@status_message = I18n.t("invite.status.recaptcha_error")
			else
				@status_message = I18n.t("invite.status.field_error")
			end
		end

		respond_to :json

	end

	private
	def message_params
		params.require(:invite).permit(:name, :leader, :email, :email_validation, :address, :location, :requested_dates, :expected_attendees, :cindy_help)
	end

end
