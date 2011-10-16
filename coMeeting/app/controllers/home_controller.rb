class HomeController < ApplicationController
	before_filter :set_locale
 
	def set_locale
	  I18n.locale = params[:locale] || I18n.default_locale
	end

	def index
	end

end
