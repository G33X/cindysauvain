class ApplicationController < ActionController::Base

  before_filter :set_locale, :only => [:new]
  skip_around_filter :set_locale_from_url

  before_action :set_locale, :custom_headers
  # helper_method :get_vimeo_thumb_url

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Get client IP
	#  request.remote_ip


  def invite_cindy
		@invite = Invite
  end

  def social_links
    @fb_link = 'https://www.facebook.com/cindysauver'
    @tw_link = 'https://twitter.com/Cindyonfire1'
    @insta_link = 'https://instagram.com/cindysauvain'
  end

  def all_resources
    @widget_news = News.where(hidden: false).order(date: :desc).limit(2)
    @widget_events = Event.order(:date).where('date > ?', Date.today).limit(2)
    @widget_testimonials = Testimonial.order(:name).limit(2)
  end

  def aside_widget_selector widget
    @aside_widget = [
        I18n.t('aside_widget_title.' + widget).html_safe,
        widget
    ]
  end

  def footer_widget_selector(widget)
    @footer_widget = [
        I18n.t('footer_widget_title.' + widget).html_safe,
        widget
    ]
  end

	def invite_form
		@invite = Invite.new
	end

  private
  def set_locale
		if params[:locale].present?
	    I18n.locale = params[:locale]
	  else
      I18n.locale = extract_locale || I18n.default_locale
		end
  end

  private
  def custom_headers
    response.headers['Access-Control-Allow-Origin'] = request.host

    require 'socket'

    if Socket.gethostname == 'iMac.local'
	    response.headers['Last-Modified'] = File.read('.env').to_datetime.httpdate
    else
      # TODO: Set the last deployment date
      response.headers['Last-Modified'] = '2016-12-08 00:00:00'
    end

    response.headers['Content-Security-Policy'] =
        "script-src 'self' https://ajax.googleapis.com " \
                          'https://www.youtube.com ' \
                          'https://www.google-analytics.com ' \
                          'https://www.google.com ' \
                          'https://s.ytimg.com ' \
                          'https://www.gstatic.com ' \
                          "'sha256-hE52k0ejP7HzU/xwH8nUhg0LHUdhUGhgnla60XVa1Dw=' " \
                          "'sha256-DzFMTIHXMvDzdMGfd109Qkc/qgMcrprkR1F6woq1Y5s='"

    if Socket.gethostname == 'iMac.local'
      response.headers['Content-Security-Policy'] += ' https://www.cindysauvain.com:35729; '
    else
      response.headers['Content-Security-Policy'] += '; '
    end

    response.headers['Content-Security-Policy'] +=
        'child-src         https://www.youtube.com ' \
                          'https://player.vimeo.com ' \
                          'https://www.google.com;'

    response.headers['X-Content-Security-Policy'] =
        "script-src 'self' https://ajax.googleapis.com " \
                          'https://www.youtube.com ' \
                          'https://www.google-analytics.com ' \
                          'https://www.google.com ' \
                          'https://s.ytimg.com ' \
                          'https://www.gstatic.com ' \
                          "'sha256-hE52k0ejP7HzU/xwH8nUhg0LHUdhUGhgnla60XVa1Dw=' " \
                          "'sha256-DzFMTIHXMvDzdMGfd109Qkc/qgMcrprkR1F6woq1Y5s='; " \
     'child-src            https://www.youtube.com ' \
                          'https://player.vimeo.com ' \
                          'https://www.google.com;'

    response.headers['X-Content-Type-Options'] = 'no-sniff'

    response.headers['X-Powered-By'] = 'Ruby on Rails 4.2'

    response.headers['Expires'] = (Time.now + 7.days).httpdate

    # HTTP 1.1 'pre-check=0, post-check=0' (IE specific)
    response.headers['Cache-Control'] = 'no-store, no-cache, must-revalidate, max-age=2592000, pre-check=0, post-check=0'
  end

  # config.action_dispatch.default_headers = {
  #     'X-Frame-Options' => 'DENY',
  #     'X-UA-Compatible' => 'IE=EmulateIE7'
  # }

  private
  def extract_locale
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first.to_sym
  end

end