class InvoiceMailer < ApplicationMailer
  def created
    @invoice = params[:invoice]
    mail(to: @invoice.emails, subject: "Invoice #{@invoice.id}")
  end
end
