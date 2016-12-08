class DonateController < ApplicationController

	def index
		@page_title = 'menu.donate'
		aside_widget_selector 'last_testimonials'
		footer_widget_selector 'next_events'
		all_resources
		social_links
		set_locale
		invite_form
	end

end