class ApplicationController < ActionController::Base
  layout :set_layout
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def set_layout
    if rodauth.logged_in?
      "application" # Layout for logged-in users
    elsif authentication_page?
      "authentication" # Layout for authentication-related pages
    else
      "unauthenticated" # Layout for general pages (homepage, pricing, etc.)
    end
  end

  def authentication_page?
    # Check if the current path matches Rodauth routes
    request.path.start_with?("/auth") || rodauth.current_route.present?
  end

  def current_account
    rodauth.rails_account
  end
  helper_method :current_account # skip if inheriting from ActionController::API
end
