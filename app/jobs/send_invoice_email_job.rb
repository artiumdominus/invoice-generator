class SendInvoiceEmailJob < ApplicationJob
  queue_as :default

  def perform(invoice:)
    InvoiceMailer.with(invoice:).created.deliver_now
  end
end