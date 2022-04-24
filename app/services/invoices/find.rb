module Invoices
  class Find < ApplicationService
    def call(id:)
      invoice = Invoice.find(id)

      { ok: { invoice: } }
    rescue ActiveRecord::RecordNotFound
      { error: :invoice_not_found }
    end
  end
end
