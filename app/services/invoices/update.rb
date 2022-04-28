module Invoices
  class Update < ApplicationService
    def call(invoice:, emails:)
      if invoice.update(emails: invoice.emails | emails)
        { ok: { invoice:, emails: } }
      else
        { error: :failure_in_invoice_update }
      end
    end
  end
end
