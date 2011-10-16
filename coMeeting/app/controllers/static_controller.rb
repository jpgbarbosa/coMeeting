class StaticController < ApplicationController
	rescue_from ActionView::MissingTemplate, :with => :invalid_page
	before_filter :set_locale
 
	def set_locale
	  I18n.locale = params[:locale] || I18n.default_locale
	end

	def show
		render params[:page]
	end

	def invalid_page
		redirect_to root_path
	end
end