class InviteMailer < ApplicationMailer
    def invite_email
      @invite = params[:invite]
      mail(to: @invite.user.email, subject: 'You’ve been invited to view an account')
    end
end  