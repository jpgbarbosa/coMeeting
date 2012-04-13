class ApplicationController < ActionController::Base
	protect_from_forgery
	before_filter :set_locale
	
	protected    
	def set_locale
		I18n.locale = params[:locale] || I18n.locale = :en
	end

	# ensure locale persists
	def default_url_options(options={})
		{:locale => I18n.locale}
	end
	
	def get_name_from(admin)
		if admin.name.empty?
			name = admin.mail.scan(/^.+(?=@.+)/)[0]
		else
			name = admin.name
		end
		name
	end
end
