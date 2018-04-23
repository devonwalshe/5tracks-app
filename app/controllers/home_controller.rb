class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  layout "splash", only: ["home"]
  
  def home
    if current_user
      redirect_to dashboard_path
    end
  end
  
  def dashboard
    
  end
end
