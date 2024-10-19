class TransactionsController < ApplicationController
  before_action :set_account
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :account
  load_and_authorize_resource through: :account

  # GET /transactions or /transactions.json
  def index
    @page = params.fetch(:page, 0).to_i
    @transactions = @account.transactions.order(created_at: :desc).offset(@page * 10).limit(10)
    @total_pages = (@account.transactions.count / 10.0).ceil
  end

  # GET /transactions/1 or /transactions/1.json
  def show
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
      format.html { redirect_to account_transactions_path, status: :see_other, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_account
      @account = Account.find(params[:account_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = @account.transactions.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:amount, :transaction_type, :notes, :account_id, :document)
    end
end
