class AgendaController < ApplicationController

  def index
    @page_title = 'menu.agenda'
    @events = Event.order(:date).where('date > ?', Date.today)

    @first_day_of_2015 = '2015-01-01 00:00:00 UTC'.to_datetime

    aside_widget_selector 'last_testimonials'
    footer_widget_selector 'last_news'
    all_resources
    social_links
    set_locale
    invite_form
  end

  def archive
    @page_title = 'menu.agenda'
    @events = Event.order(:date).where('date < ?', Date.today)

    @first_day_of_2015 = '2015-01-01 00:00:00 UTC'.to_datetime

    aside_widget_selector 'last_testimonials'
    footer_widget_selector 'last_news'
    all_resources
    social_links
    set_locale
    invite_form
  end

  def show
    @page_title = 'menu.agenda'
    @event = Event.find params[:id]
    @first_day_of_2015 = '2015-01-01 00:00:00 UTC'.to_datetime

    aside_widget_selector 'last_testimonials'
    footer_widget_selector 'last_news'
    all_resources
    social_links
    set_locale
		invite_form
  end

end
