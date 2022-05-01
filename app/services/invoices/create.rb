module Invoices
  class Create < ApplicationService
    def call(user:, invoice:)
      invoice = user.invoices.create(invoice)

      { ok: { invoice: } }
    rescue ActiveRecord::ActiveRecordError
      { error: :failure_in_invoice_creation }
    end
  end
end
