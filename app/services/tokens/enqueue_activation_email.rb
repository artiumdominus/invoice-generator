module Tokens
  class EnqueueActivationEmail < ApplicationService # PubActivationEmail
    def call(token:)
      TokenMailer.with(token:).activation.deliver_later

      { ok: { success: true } }
    end
  end
end
