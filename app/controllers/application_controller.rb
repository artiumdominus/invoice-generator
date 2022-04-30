class ApplicationController < ActionController::Base

  def authenticate!
    if !current_user_token
      redirect_to(root_path, notice: "Not Authorized") 
    else
      case authenticate_by_token
      in { ok: { user: } }
        @current_user = user
      in { error: }
        redirect_to(root_path, notice: "Not Authorized")
      end
    end
  end

  def authenticated?
    if current_user_token && authenticate_by_token in { ok: { user: } }
      redirect_to(invoices_path)
    end
  end

  def authenticate
    if current_user_token && authenticate_by_token in { ok: { user: } }
      @current_user = user
    end
  end

  def authenticate_by_token = Tokens::Authenticate[code: current_user_token]

  helper_method :current_user
  def current_user = @current_user
  def current_user_token = @current_user_token ||= session[:current_user_token]

  def alert!(error) = @alert = t("#{controller_name}.#{action_name}.#{error}")
end
