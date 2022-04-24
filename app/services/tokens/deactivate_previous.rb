module Tokens
  class DeactivatePrevious < ApplicationService
    def call(token:)
      Token
        .where(user: token.user, active: true)
        .where.not(id: token.id)
        .update(active: false)

      { ok: { token: } }
    end
  end
end