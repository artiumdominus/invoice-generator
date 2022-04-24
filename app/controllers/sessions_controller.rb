class SessionsController < ApplicationController
  before_action :authenticated?, only: :new

  def show = redirect_to(new_sessions_path)
  def new; end

  def create
    case Tokens::UseCases::Login[code:]
    in { ok: data }
      session[:current_user_token] = code

      redirect_to(invoices_path, notice: "Valid Token")
    in { error: }
      redirect_to(root_path, notice: "Invalid Token")
    end
  end

  def destroy
    session.delete(:current_user_token)

    redirect_to(root_path)
  end

  private

  def code = @code ||= params[:token]
end