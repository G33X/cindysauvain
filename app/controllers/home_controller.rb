class HomeController < ApplicationController

	def index
		@page_title = 'menu.home'
		@news = News.where(hidden: false).order(date: :desc)

		aside_widget_selector 'next_events'
		footer_widget_selector 'last_testimonials'
		all_resources
		social_links
		invite_form

		# News.where(:group => "1", :date => "2014-01-01").last

		respond_to do |format|
			format.html
			format.jsonld
		end

	end

	def show
		@page_title = 'menu.home'
		@news = News.where(hidden: false).find(params[:id])

		@date_day = l @news.date, format: '%-d'
		@date_month = l @news.date, format: '%B'
		@date_year = l @news.date, format: '%Y'
		@full_date = l @news.date, format: '%Y-%m-%d'

		aside_widget_selector 'next_events'
		footer_widget_selector 'last_testimonials'
		all_resources
		social_links
		invite_form
	end

end
