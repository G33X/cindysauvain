class MediasController < ApplicationController

  def index
    @page_title = 'menu.medias'
    @medias = Medias.order media_id: :desc

    aside_widget_selector 'next_events'
    footer_widget_selector 'last_news'
    all_resources
    social_links
    set_locale
    invite_form
  end

  def download
    send_file 'public/audio/preach-in-germany.mp3', :type => 'audio/mp3', :disposition => 'attachment'
  end

end
