json.array! @medias.each do |res|
		json.set! '@context', 'http://schema.org'
		json.set! '@type', 'BookmarkAction'

		json.agent do
			json.set! '@type', 'Person'
			json.name 'Cindy Sauvain'
		end

		json.object do
			json.set! '@type', 'ImageObject'
			json.datePublished res.media_date
			json.embedUrl res.media_link
			json.caption res.caption
			json.contentUrl res.image_url
			json.width res.image_width
			json.height res.image_height
		end
end
