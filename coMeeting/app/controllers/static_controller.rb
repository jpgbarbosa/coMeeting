class StaticController < ApplicationController

	def about_us
	end
	
end


#class StaticController < ApplicationController
#	rescue_from ActionView::MissingTemplate, :with => :invalid_page

#	def about_us
#		render params[:page]
#	end
#
#	def invalid_page
#		redirect_to root_path
#	end
#end