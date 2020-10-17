class ApplicationController < ActionController::Base
  def not_found
    render :file => "#{Rails.root}/public/error.html", :status => 404, :layout => false
  end

end

