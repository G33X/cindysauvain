json.set! '@context', 'http://schema.org'
json.set! '@type', 'Person'
json.name 'Cindy Sauvain'
json.gender 'Female'

json.address do
	json.set! '@type', 'PostalAddress'
	json.streetAddress 'Chemin du Champ-des-Pierres 20'
	json.postalCode '1052'
	json.addressLocality 'Le Mont-sur-Lausanne'
	json.addressCountry t 'footer.country'
end

json.url root_url

json.image "#{request.protocol}#{request.domain}#{image_path 'cindy.jpg'}"

json.sameAs %W(
		            https://www.facebook.com/cindysauver
		            https://twitter.com/Cindyonfire1
		            https://instagram.com/cindysauvain
            )
