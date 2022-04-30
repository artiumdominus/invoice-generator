class TokensController < ApplicationController
  before_action :authenticated?, only: :new

  def index = redirect_to(new_token_path)
  def new; end

  def create
    case Tokens::UseCases::Generate[email:]
    in { ok: data }
      redirect_to new_token_path, { notice: "Token created with success, access your email to validate your token." }
    in { error: }
      alert!(error)
      render :new, status: :unprocessable_entity
    end
  end

  def activate
    case Tokens::UseCases::Activate[code:]
    in { ok: { token: } }
      session[:current_user_token] = token.id

      redirect_to(invoices_path, notice: "Welcome.")
    in { error: }
      alert!(error)
    end
  end

  private

  def email = params[:email]
  def code = params[:id]
end
