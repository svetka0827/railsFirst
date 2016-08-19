class SessionssController < ApplicationController
  def index
  end

  def borrower_login
    borrower = Borrower.find_by(email: params[:email])

    if borrower && borrower.authenticate(params[:password])
      session[:borrower_id] = borrower.id
      redirect_to '/borrower'
    else
      flash[:errors] = ["Invalid combination"]
      redirect_to :back
    end
  end

  def borrower_destroy
    reset_session
    redirect_to :root
  end



  def lender_login
    lender = Lender.find_by(email: params[:email])

    if lender && lender.authenticate(params[:password])
      session[:lender_id] = lender.id
      redirect_to '/lender'
    else
      flash[:errors] = ["Invalid combination"]
      redirect_to :back
    end
  end

  def lender_destroy
    reset_session
    redirect_to :root
  end


end
