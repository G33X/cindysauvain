date_format @event

json.set! '@context', 'http://schema.org'
json.set! '@type', 'Event'

if I18n.locale == :en
	json.name @event.title
elsif I18n.locale == :fr
	json.name @event.title_fr
end

if @event.date_from.nil?
	json.startDate @full_date
else
	json.startDate @full_date_from
end

unless @event.date_from.nil?
	json.endDate @full_date
end

unless @event.speaker.empty?
	json.performer @event.speaker
end

json.uri agenda_path(@event.id)

unless @event.image.empty?
	json.image @event.image
end

json.location do
	json.set! '@type', 'Place'

	if I18n.locale == :en
		json.name @event.building
	elsif I18n.locale == :fr
		json.name @event.building_fr
	end

	json.address do
		json.set! '@type', 'PostalAddress'
		json.streetAddress @event.address
		json.postalCode @event.zip
		json.addressLocality @event.city
		json.addressCountry 'CH' #@event.country
	end

end

if I18n.locale == :en
	unless @event.details.empty?
		json.description sanitize(strip_tags(@event.details))
	end
end
if I18n.locale == :fr
	unless @event.details_fr.empty?
		json.description sanitize(strip_tags(@event.details_fr))
	end
end

if !@event.website.nil? && @event.additionnal_website.nil?
	json.sameAs [
			            @event.website
	            ]
elsif !@event.additionnal_website.nil?
	json.sameAs %W(
	              #{@event.website}
	              #{@event.additionnal_website}
	            )
end
