class ApplicationController < ActionController::Base
  before_filter :set_locale, :login_required
  protect_from_forgery
  include AuthenticatedSystem
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
