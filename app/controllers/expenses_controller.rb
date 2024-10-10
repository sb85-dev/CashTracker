class ExpensesController < ApplicationController
    before_action :set_account
  
    def create
      @expense = @account.expenses.build(expense_params)
      if @expense.save
        redirect_to account_path(@account), notice: 'Expense added successfully.'
      else
        render :new
      end
    end
  
    private
  
    def set_account
      @account = current_user.accounts.find(params[:account_id])
    end
  
    def expense_params
      params.require(:expense).permit(:category, :amount)
    end
end