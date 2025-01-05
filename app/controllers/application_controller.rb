class ApplicationController < ActionController::Base
  layout :set_layout
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def set_layout
    if business_related_view?
      "business" # Layout for business-related views
    elsif rodauth.logged_in?
      "application" # Layout for logged-in users
    elsif authentication_page?
      "authentication" # Layout for authentication-related pages
    else
      "unauthenticated" # Layout for general pages (homepage, pricing, etc.)
    end
  end

  def business_related_view?
    params[:business_id].present? || controller_with_business_association? || business_show_page? || business_dashboard_page?
  end
  
  def controller_with_business_association?
    %w[customers products orders].include?(controller_name)
  end
  
  def business_show_page?
    controller_name == 'businesses' && action_name == 'show'
  end
  
  def business_dashboard_page?
    controller_name == 'businesses' && action_name == 'dashboard'
  end




  

  #######################################################################################################################
  # rodauth
  #######################################################################################################################

  def authentication_page?
    # Check if the current path matches Rodauth routes
    request.path.start_with?("/auth") || rodauth.current_route.present?
  end

  def current_account
    rodauth.rails_account
  end
  helper_method :current_account # skip if inheriting from ActionController::API

  def authenticate!
    rodauth.require_account # redirect to login page if not authenticated
  end
end
