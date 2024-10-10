class IncomesController < ApplicationController
    before_action :set_account
  
    def create
      @income = @account.incomes.build(income_params)
      if @income.save
        redirect_to account_path(@account), notice: 'Income added successfully.'
      else
        render :new
      end
    end
  
    private
  
    def set_account
      @account = current_user.accounts.find(params[:account_id])
    end
  
    def income_params
      params.require(:income).permit(:source, :amount)
    end
end
  
