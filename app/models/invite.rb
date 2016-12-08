class Invite
	include ActiveModel::Model
	attr_accessor :name, :email, :email_validation, :leader, :phone, :location, :address, :requested_dates, :expected_attendees, :other_speaker, :cindy_help, :status

	validates :name, :email, :email_validation, :leader, :location, :address, :requested_dates, :expected_attendees, :cindy_help, presence: true
end
