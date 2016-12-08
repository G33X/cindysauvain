json.array! @testimonials.each do |res|
	json.set! '@context', 'http://schema.org'
	json.set! '@type', 'CreativeWork'

	json.author 'Cindy Sauvain'
	json.genre 'Testimonial'

	json.datePublished res.created_at

	json.name res.name

	if I18n.locale == :en
		if sanitize(strip_tags(res.text)[0..1]) == '––'
			json.text sanitize(strip_tags(res.text_fr))
			json.inLanguage 'fr'
		else
			json.text sanitize(strip_tags(res.text))
			json.inLanguage 'en'
		end
	elsif I18n.locale == :fr
		if sanitize(strip_tags(res.text_fr)[0..1]) == '––'
			json.text sanitize(strip_tags(res.text))
			json.inLanguage 'en'
		else
			json.text sanitize(strip_tags(res.text_fr))
			json.inLanguage 'fr'
		end
	end

	json.image res.image
	json.url "#{testimonials_url}##{res.id}"

end
