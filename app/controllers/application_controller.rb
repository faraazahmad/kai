class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  inertia_share do
    {
      user: current_user,
    } if user_signed_in?
  end

  def dashboard
    render inertia: 'Dashboard', props: {}
  end
end
