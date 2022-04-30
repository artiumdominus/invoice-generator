module Invoices
  class Changeset < ApplicationService
    def call(invoice: nil) = Invoice.new(params(invoice))

    def params(invoice)
      if invoice.nil?
        nil
      else
        invoice.merge(
          total_amount_due_cents: invoice[:total_amount_due].to_f * 100
        )
        .except(:total_amount_due)
      end
    end
  end
end
