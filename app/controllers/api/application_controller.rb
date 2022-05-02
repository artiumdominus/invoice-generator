module Api
  class ApplicationController < ActionController::API

    def authenticate!
      bearer_token = request.headers["Authorization"]&.split(' ')&.last

      case Tokens::Authenticate[code: bearer_token]
      in { ok: { user: } }
        @current_user = user
      in { error: }
        render json: { error: }, status: :unauthorized
      end
    end

    def current_user = @current_user
  end
end