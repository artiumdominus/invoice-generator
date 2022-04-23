class SessionsController < ApplicationController
  def index
    if session[:current_user_token] == '123456'
      redirect_to(invoices_path)
    end
  end

  def create
    if params[:token] == '123456'
      session[:current_user_token] = params[:token]

      redirect_to(invoices_path, notice: "Token válido")
    else
      redirect_to(root_path, notice: "Token inválido")
    end
  end

  def delete
    session.delete(:current_user_token)

    redirect_to(root_path)
  end
end