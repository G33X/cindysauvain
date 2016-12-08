class PrivacyPolicyController < ApplicationController

	def index
		aside_widget_selector 'last_news'
		footer_widget_selector 'next_events'
		all_resources
		social_links
		set_locale
		invite_form
	end

end
