json.set! "@context", "http://schema.org"
json.set! "@type", "AboutPage"

json.url about_index_url

if I18n.locale == :en
	json.video do
		json.name "https://player.vimeo.com/video/134775120?color=e3000f&title=0&byline=0&portrait=0"
		json.description "Needing donations: Cindy needs donations for her minisrty"
		json.thumbnailUrl "https://i.vimeocdn.com/video/528415111_295x166.jpg"
		json.uploadDate "2015-07-28"
	end
end

json.mainEntity do
	json.set! "@type", "Person"
	json.name "Cindy Sauvain"

	json.description sanitize("#{t 'about.first_p'} #{t 'about.second_p'}")

	json.image "#{request.protocol}#{request.domain}#{image_path 'cindy.jpg'}"
end