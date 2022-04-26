class InvoiceMailer < ApplicationMailer
  def created
    @invoice = params[:invoice]

    pdf_title = "invoice_#{@invoice.date.strftime('%Y%m%d')}_#{@invoice.id}.pdf"
    attachments[pdf_title] = WickedPdf.new.pdf_from_string(
      render_to_string(
        template: 'invoices/download',
        layout: 'pdf',
        locals: { invoice: @invoice },
        page_size: 'A4',
        orientation: 'Landscape',
        lowquality: true,
        zoom: 1,
        dpi: 75
      )
    )

    mail(to: @invoice.emails, subject: "Invoice #{@invoice.id}")
  end
end
