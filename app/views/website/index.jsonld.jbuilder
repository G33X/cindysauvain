json.set! '@context', 'http://schema.org'
json.set! '@type', 'WebSite'

json.name 'Cindy Sauvain'

json.url root_url

json.headline "#{t 'header.verse'} #{t 'header.ref'}"
json.description t 'tagline.text'

json.copyrightHolder 'Cindy Sauvain'
json.copyrightYear 2015

json.producer do
	json.array! [
			            {
					            '@type': 'Person',
					            'name': 'Maryne Roye',
					            'gender': 'Female',
					            'sameAs': [
							            'https://www.facebook.com/maryne.roye'
					            ]
			            },
			            {
					            '@type': 'Person',
					            'name': 'Guillaume Suard',
					            'gender': 'Male',
					            'sameAs': [
							            'https://www.facebook.com/geex4'
					            ]
			            }
	            ]
end