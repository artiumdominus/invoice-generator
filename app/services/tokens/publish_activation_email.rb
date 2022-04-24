module Tokens
  class PublishActivationEmail < ApplicationService
    def call(token:)
      TokenMailer.with(token:).activation.deliver_later

      { ok: { success: true } }
    end
  end
end
