class ApplicationController < ActionController::Base
  layout :set_layout
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def set_layout
    rodauth.logged_in? ? "application" : "unauthenticated"
  end
end
