class TokenMailer < ApplicationMailer
  def activation
    @token = params[:token]
    @user = @token.user
    mail to: @user.email, subect: "-=[Token Activation]=-"
  end
end