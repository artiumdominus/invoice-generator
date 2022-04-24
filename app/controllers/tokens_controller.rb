class TokensController < ApplicationController
  def new; end

  def create
    email = params[:email]
    puts({ email: })

    case Tokens::UseCases::Generate[email:]
    in { ok: data }
      redirect_to new_token_path, { notice: "Token created with success, access your email to validate your token." }
    in { error: }
      @error = error
      # TODO: deal error
    end
  end

  def activate
  end

  private

  def email = params[:email]
end
