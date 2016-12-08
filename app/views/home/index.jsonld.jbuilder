json.array! @news.each do |res|
  json.set! '@context', 'http://schema.org'
	json.set! '@type', 'NewsArticle'
	json.author 'Cindy Sauvain'

	json.publisher do
		json.set! '@type', 'Person'
		json.name 'Cindy Sauvain'
	end

	json.datePublished res.date
	json.dateModified res.updated_at.to_date

  json.mainEntityOfPage do
    json.set! '@type', 'WebPage'
    json.set! '@id', home_url(res.id)
	end

  if I18n.locale == :en
		json.headline res.title
	end
	if I18n.locale == :fr
		json.headline res.title_fr
	end

	unless res.video.empty?
		if res.video_src == 'YouTube'
			json.image "http://img.youtube.com/vi/#{res.video}/0.jpg"

			json.video do
				if I18n.locale == :en
					json.name res.title
				end
				if I18n.locale == :fr
					json.name res.title_fr
				end
				if I18n.locale == :en
					json.description sanitize(strip_tags(res.text.html_safe))
				end
				if I18n.locale == :fr
					json.description sanitize(strip_tags(res.text_fr))
				end
				json.thumbnailUrl "http://img.youtube.com/vi/#{res.video}/default.jpg"
				json.uploadDate res.date
				json.contentUrl "https://www.youtube.com/embed/#{res.video}?showinfo=0"
			end
		elsif res.video_src == 'Vimeo'
			json.image get_vimeo_thumb_url res.video, nil

			json.video do
				if I18n.locale == :en
					json.name res.title
				end
				if I18n.locale == :fr
					json.name res.title_fr
				end
				if I18n.locale == :en
					json.description sanitize(strip_tags(res.text.html_safe))
				end
				if I18n.locale == :fr
					json.description sanitize(strip_tags(res.text_fr))
				end
				json.thumbnailUrl get_vimeo_thumb_url res.video, 'thumb'
				json.uploadDate res.date
				json.contentUrl "https://player.vimeo.com/video/#{res.video}?color=e3000f&title=0&byline=0&portrait=0"
			end
		end
	end

	if I18n.locale == :en
		json.articleBody sanitize(strip_tags(res.text.html_safe))
	end
	if I18n.locale == :fr
		json.articleBody sanitize(strip_tags(res.text_fr))
	end

	json.sameAs %W(
		https://www.facebook.com/sharer/sharer.php?app_id=1087950351220080&display=popup&u=https%3A%2F%2Fwww.cindysauvain.com%2F#{I18n.locale}%2F#{res.id.to_s}
		https://twitter.com/intent/tweet?lang=#{I18n.locale}&text=https%3A%2F%2Fwww.cindysauvain.com%2F#{I18n.locale}%2F#{res.id.to_s}
		https://plus.google.com/share?hl=#{I18n.locale}&url=https%3A%2F%2Fwww.cindysauvain.com%2F#{I18n.locale}%2F#{res.id.to_s}
	)

	json.url home_url(res.id)

	unless res.image.empty?
		json.image res.image
	end
end