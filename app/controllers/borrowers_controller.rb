class BorrowersController < ApplicationController
  before_action :require_login_B, except: [:login, :create]

  def login
  end


  def create
    borrower = Borrower.create(borrower_params)
    if borrower.save
      redirect_to :root
    else
      flash[:errors] = borrower.errors.full_messages
      redirect_to :back
    end
  end


  def show
    @borrower=Borrower.find(session[:borrower_id])
    @lenders=Lender.find_by_sql("SELECT lenders.first_name, lenders.last_name, lenders.email, sum(histories.amount) as raisedd
              FROM lenders
              LEFT JOIN histories ON lenders.id=histories.lender_id
              WHERE histories.borrower_id='#{session[:borrower_id]}'
              GROUP BY lenders.id")
    @totalRaised=Lender.find_by_sql("SELECT sum(histories.amount) as raisedd
FROM lenders
LEFT JOIN histories ON lenders.id=histories.lender_id
WHERE histories.borrower_id= '#{session[:borrower_id]}'").first

  end

private
  def borrower_params
    params.require(:borrower).permit(:first_name, :last_name, :email, :purpose, :description, :money, :password, :password_confirmation)
  end 
end
