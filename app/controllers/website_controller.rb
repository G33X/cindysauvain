class WebsiteController < ApplicationController

	def index
		respond_to do |format|
			format.jsonld
		end
	end

end