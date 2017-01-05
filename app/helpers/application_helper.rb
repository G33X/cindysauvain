module ApplicationHelper

	def controller?(*controller)
		controller.include?(params[:controller])
	end

	def nav_link(link_text, link_path)
		class_name = current_page?(link_path) ? 'active' : ''

		content_tag(:li, class: class_name) do
			concat link_to(link_text, link_path)
			concat content_tag(:span)
		end
	end

	# def json_ld_tag(controller)
	#   content_tag(:script, "", type: "application/ld+json") do
	#     raw("{\"@context\": \"#{url_for(controller: controller, action: 'index', format: 'jsonld')}\"}")
	#   end
	# end

	def meta_desc_tag(key)
		tag(:meta, {name: "description", content:"#{t key}"}, true)
	end

	def json_ld_tag(controller)
		content_tag(:script, "", type: "application/ld+json") do
			sanitize render(file: "#{controller}/index", formats: 'jsonld')
		end
	end

	def date_format resource, short_month = false


		# Date from
		if resource.class == Event
			unless resource.date_from.nil?

				@date_from_hours_en = l resource.date_from, format: '%l'
				@date_from_minutes = l resource.date_from, format: '%M'
				@date_from_us_time = l resource.date_from, format: '%p'
				@date_from_hours_fr = l resource.date_from, format: '%k'
				@date_from_day = l resource.date_from, format: '%e'

				if short_month
					@date_from_month = l resource.date_from, format: '%b'
				else
					@date_from_month = l resource.date_from, format: '%B'
				end

				@date_from_year = l resource.date_from, format: '%Y'
				@full_date_from = l resource.date_from, format: '%Y-%m-%d'

			end
		end


		# Date to
		@date_hours_en = l resource.date, format: '%l'
		@date_minutes = l resource.date, format: '%M'
		@date_us_time = l resource.date, format: '%p'
		@date_hours_fr = l resource.date, format: '%k'
		@date_day = l resource.date, format: '%-d'

		if short_month
			@date_month = l resource.date, format: '%b'
		else
			@date_month = l resource.date, format: '%B'
		end

		@date_year = l resource.date, format: '%Y'
		@full_date = l resource.date, format: '%Y-%m-%d'

		puts nil
	end

	def get_media_date date, format
		case format
			when 'day'
				l Time.at(date), format: '%-d'
			when 'month'
				l Time.at(date), format: '%B'
			when 'year'
				l Time.at(date), format: '%Y'
		end
	end


	def get_vimeo_error_url
		(I18n.locale == :en) ? asset_path('assets/vimeo-error-en.jpg') : asset_path('assets/vimeo-error-fr.jpg')
	end

		def get_vimeo_thumb_url(video_id, size, video_cover = false)
		require 'net/https'
		require 'json'
		uri = URI "https://api.vimeo.com/videos/#{video_id}/pictures?access_token=cb1da9d7b105ec28eb606eab6d4e5894"

		http = Net::HTTP.start(uri.host, uri.port, use_ssl: true)
		request = Net::HTTP::Get.new(uri.request_uri)
		response = http.request request

		if response
			if Net::HTTPSuccess
				parsed_response = JSON.parse(response.body)

				unless parsed_response['data'].nil?
					data = parsed_response['data'][0]['sizes']

					if size == 'thumb'
					return data[0]['link']
					else
					if video_cover
						if !data[3]['link_with_play_button']
							# TODO: Make a sample video cover
							return data[2]['link_with_play_button']
						else
							return data[3]['link_with_play_button']
						end
					else
						if !data[3]['link']
							# TODO: Make a sample video cover
							return data[2]['link']
						else
							return data[3]['link']
						end
					end
					end
				else
					get_vimeo_error_url
				end
			end
		end

	end


	def get_from_instagram(arg)

		require 'net/https'
		require 'json'
		# uri = URI 'http://api.instagram.com/oembed?url=http://instagram.com/p/0a0bfAIAph'
		# USER ID: 1097652049

		# uri = URI 'https://api.instagram.com/v1/users/1097652049/media/recent/?client_id=3e9cc8e7c0cc422dac78daf9ed18581f&access_token=228003586.3e9cc8e.267dff5b0a1248e986a2e882102e8708'

		# arg = '1261719406969359348_1097652049'
		uri = URI "https://api.instagram.com/v1/media/#{arg}?client_id=3e9cc8e7c0cc422dac78daf9ed18581f&access_token=228003586.3e9cc8e.267dff5b0a1248e986a2e882102e8708"

		http = Net::HTTP.start(uri.host, uri.port, use_ssl: true)
		request = Net::HTTP::Get.new(uri.request_uri)
		response = http.request request

		if response
			if Net::HTTPSuccess
				parsed_response = JSON.parse(response.body)
				data = parsed_response['data']
				@http_code = parsed_response['meta']['code']
				@answer = 'N'

				unless data.nil?
					@answer = 'OK'
					datetime = Time.at data['created_time'].to_i

					@image_url = data['images']['standard_resolution']['url']
					@image_width = data['images']['standard_resolution']['width']
					@image_height = data['images']['standard_resolution']['height']

					if data['caption'].nil?
						@text = ''
					else
						@text = data['caption']['text']
					end

					@likes = data['likes']['count']
					@link = data['link']

					@date_day = l datetime, format: '%-d'
					@date_month = l datetime, format: '%B'
					@date_year = l datetime, format: '%Y'
					@date_iso8601 = l datetime, format: '%Y-%m-%d'

				else
					# @answer = 'Bad response'
					@answer = data.class
				end

				puts nil
			end

		else
			warn 'Error when parsing data'
		end

	end


	def image_pos res, element
		if res.image.empty?
			@image_pos = 'hidden'
			@text_pos = 'wide'
		elsif res.image_pos == 'Left'
			@image_pos = 'left'
			@text_pos = 'right'
		elsif res.image_pos == 'Right'
			@image_pos = 'right'
			@text_pos = 'left'
		end
		if element == 'image'
			@image_pos
		elsif element == 'text'
			@text_pos
		end
	end


end
