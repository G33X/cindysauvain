json.array! @events do |res|
	date_format res

	json.set! "@context", "http://schema.org"
	json.set! "@type", "Event"

	if I18n.locale == :en
		json.name res.title
	elsif I18n.locale == :fr
		json.name res.title_fr
	end

	if res.date_from.nil?
		json.startDate @full_date
	else
		json.startDate @full_date_from
	end

	unless res.date_from.nil?
		json.endDate @full_date
	end

	unless res.speaker.empty?
		json.performer res.speaker
	end

	json.url agenda_url(res.id)

	unless res.image.empty?
		json.image res.image
	end

	json.location do
		json.set! "@type", "Place"

		if I18n.locale == :en
			if res.building.empty?
				json.name "[Location not provided]"
			else
				json.name res.building
			end
		elsif I18n.locale == :fr
			unless res.building_fr.nil?
				if res.building_fr.empty?
					json.name "[Lieu non communiqué]"
				else
					json.name res.building_fr
				end
			end
		end

		json.address do
			json.set! "@type", "PostalAddress"
			json.streetAddress res.address
			json.postalCode res.zip
			json.addressLocality res.city

			if I18n.locale == :en
				json.addressCountry res.country
			elsif I18n.locale == :fr
				json.addressCountry res.country_fr
			end

		end

	end

	if I18n.locale == :en
		unless res.building_fr.nil?
			unless res.details.empty?
				json.description sanitize(strip_tags(res.details))
			end
		end
	end
	if I18n.locale == :fr
		unless res.details_fr.nil?
			unless res.details_fr.empty?
				json.description sanitize(strip_tags(res.details_fr))
			end
		end
	end

	unless res.website.nil? || res.website.empty?
		json.sameAs do
			json.array! [res.website, res.additionnal_website]
		end
	end

end
