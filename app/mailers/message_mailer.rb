class MessageMailer < ApplicationMailer

	def check_field field
		field == t('invite.name') ? nil : field
	end

	def send_invite msg, ua

		ENV['SSL_CERT_FILE'] = "#{Rails.root.to_s}/ssl/cacert.pem"

		server_url = "mg.cindysauvain.com"
		mg_url = "https://api:key-a2fe6aa27319bebb7d7606ea35986d88@api.mailgun.net/v3/mg.cindysauvain.com/messages"
		receiver = "cindy.sauvain@gmail.com"
		dev = "g33x@icloud.com"
		subject = "Invite via cindysauvain.com website"
		lang = I18n.locale == :en ? 'English' : 'Français'

		html_content =
				"Language: #{lang} \n"\
				"Name: #{check_field msg.name} \n"\
				"Leader: #{check_field msg.leader} \n"\
				"Email: #{check_field msg.email} \n"\
				"Phone: #{check_field msg.phone} \n"\
				"Address: #{check_field msg.address} \n"\
				"Location: #{check_field msg.location} \n"\
				"Requested dates: #{check_field msg.requested_dates} \n"\
				"Expected no of attendees: #{check_field msg.expected_attendees} \n"\
				"Other speaker: #{check_field msg.other_speaker} \n\n"\
				"Message: \n #{check_field msg.cindy_help}"


		require 'mailgun'

		mg_client = Mailgun::Client.new "key-a2fe6aa27319bebb7d7606ea35986d88"

		mb_obj = Mailgun::MessageBuilder.new

		mb_obj.set_from_address "#{msg.name} <#{msg.email}>"
		mb_obj.add_recipient :to, "Cindy Sauvain <#{receiver}>"
		mb_obj.add_recipient :cc, "Guillaume Suard <#{dev}>"
		mb_obj.add_custom_parameter 'v:user-agent', ua
		mb_obj.set_subject subject
		mb_obj.set_text_body html_content
		# mb_obj.set_html_body render_to_string("invites/create")
		mg_client.send_message server_url, mb_obj


=begin
		require 'rest-client'

		@result = RestClient.post mg_url,
				:from =>  "#{msg.name} via invite form <#{msg.email}>",
				:to => "Cindy Sauvain <#{receiver}>",
				:cc => "Guillaume Suard for bugfix purpose <#{dev}>",
				:subject => subject,
				:text => html_content
=end

	end

end
