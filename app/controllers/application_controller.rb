class ApplicationController < ActionController::Base
  before_filter :set_i18n_locale_from_params
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html do
        redirect_to admin_root_path, :alert => exception.message
      end
    end
  end

  def current_ability
    @current_ability ||= Ability.new(current_admin_user)
  end

  protected
    def set_i18n_locale_from_params
      if params[:locale]
    	if I18n.available_locales.include?(params[:locale].to_sym)   			
          I18n.locale = params[:locale]
    	else
          flash.now[:notice] = "#{params[:locale]} translation not available"
    	  logger.error flash.now[:notice]
    	end
      end
    end

  def default_url_options 
   	{:locale => I18n.locale}
  end
end
