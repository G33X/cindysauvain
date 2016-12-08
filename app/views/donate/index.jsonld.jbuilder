json.set! '@context', 'http://schema.org'
json.set! '@type', 'WebPage'

json.url donate_index_url
json.headline t 'donate.first_text'
json.description t 'donate.second_text'

json.potentialAction do
	json.set! '@type', 'DonateAction'
	json.instrument 'Bank account number, PayPal'

	json.recipient do
		json.set! '@type', 'Person'
		json.name 'Cindy Sauvain'
	end

end
