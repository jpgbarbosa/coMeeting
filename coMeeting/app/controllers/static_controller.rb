class StaticController < ApplicationController
	rescue_from ActionView::MissingTemplate, :with => :invalid_page

	def show
		render params[:page]
	end

	def invalid_page
		redirect_to root_path
	end
end