class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_login_B
    redirect_to :root if session[:borrower_id] == nil 
  end

   def require_login_L
    redirect_to :root if session[:lender_id] == nil 
  end

end
