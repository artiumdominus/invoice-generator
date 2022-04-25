module Invoices
  class Create < ApplicationService
    def call(user:, invoice:)
      invoice = user.invoices.create(invoice)

      if invoice.persisted?
        { ok: { invoice: } }
      else
        { error: :failure_in_invoice_creation }
      end
    end
  end
end