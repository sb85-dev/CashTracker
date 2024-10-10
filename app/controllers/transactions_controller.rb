class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]
  before_action :set_account

  # GET /transactions or /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1 or /transactions/1.json
  def show
    @account = Account.find(params[:id])
    @transaction = @account.transaction.find(params[:transaction_id]) if params[:transaction_id]
  end

  # GET /transactions/new
  def new
    @transaction = @account.transactions.build
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = @account.transactions.build(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @account, notice: "Transaction was successfully created." }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy!

    respond_to do |format|
      format.html { redirect_to transactions_path, status: :see_other, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_account
      @account = current_user.accounts.find(params[:account_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:amount, :transaction_type, :notes, :account_id)
    end
end
