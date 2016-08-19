class LendersController < ApplicationController
  before_action :require_login_L, except: [:login, :create]

  def login
  end

  def create
    lender = Lender.create(lender_params)
    if lender.save
      redirect_to :root
    else
      flash[:errors] = lender.errors.full_messages
      redirect_to :back
    end

  end



  def show
  	@lender=Lender.find(session[:lender_id])
  	@borrowers=Borrower.all
    @borrowers2=Borrower.find_by_sql("SELECT borrowers.id, borrowers.first_name, borrowers.last_name,borrowers.purpose,
      borrowers.description, borrowers.money, borrowers.raised, sum(histories.amount) as raisedd
      FROM borrowers
      LEFT JOIN histories ON borrowers.id=histories.borrower_id
      WHERE histories.lender_id= '#{session[:lender_id]}'
      GROUP by borrowers.id")

      #lender=Lender.find(session[:lender_id])
      #lender.money=lender.money -#{session[:borrower_id]}
      #lender.save
  end


  def process_lend
  	history=History.create(amount:money_params['amount'],lender_id:session[:lender_id],borrower_id:params[:id])
  	lender=Lender.find(session[:lender_id])

  	redirect_to :back

  end



private
  def lender_params
    params.require(:lender).permit(:first_name, :last_name, :email, :money, :password, :password_confirmation)
  end
  def money_params
  	params.require(:money).permit(:amount)
  end

end
