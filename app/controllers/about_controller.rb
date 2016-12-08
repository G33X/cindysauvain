class AboutController < ApplicationController

  def index
	  @page_title = 'menu.about'
	  aside_widget_selector 'next_events'
    footer_widget_selector 'last_testimonials'
    all_resources
    social_links
    set_locale
	  invite_form
  end

end
