class AccountsController < ApplicationController
  before_action :set_account, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  # create budget view
  def budget
  end

  # GET /accounts or /accounts.json
  def index
    @owned_accounts = current_user.accounts
    @followed_accounts = Account.joins(:invites).where(invites: { user: current_user, status: 'accepted' })
  end
  

  # GET /accounts/1 or /accounts/1.json
  def show
    @transactions = @account.transactions
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts or /accounts.json
  def create
    @account = current_user.accounts.build(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: "Account was successfully created." }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: "Account was successfully updated." }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1 or /accounts/1.json
  def destroy
    @account = current_user.accounts.find(params[:id])
    @account.destroy!

    respond_to do |format|
      format.html { redirect_to accounts_path, status: :see_other, notice: "Account was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:name, :balance, :user_id)
    end
end
