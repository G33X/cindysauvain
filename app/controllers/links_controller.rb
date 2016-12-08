class LinksController < ApplicationController

  def index
    @page_title = 'menu.links'
    aside_widget_selector 'next_events'
    footer_widget_selector 'last_news'
    all_resources
    social_links
    set_locale
    invite_form
  end

end
