class InvitesController < ApplicationController

    def create
      @account = current_user.accounts.find(params[:account_id])
      @invite = @account.invites.build(user: current_user)
  
      if @invite.save
        # Send invite link to the user
        InviteMailer.with(invite: @invite).invite_email.deliver_later
        flash[:notice] = "Invite sent!"
      else
        flash[:alert] = "Could not send invite."
      end
      redirect_to @account
    end
  
    def show
      @invite = Invite.find_by(token: params[:token])
      @account = @invite.account
    end
  
    def accept
      @invite = Invite.find_by(token: params[:token])
      if @invite.update(status: 'accepted')
        flash[:notice] = "Invite accepted!"
      else
        flash[:alert] = "Could not accept invite."
      end
      redirect_to @invite.account
    end
end
