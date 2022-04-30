class Invoice < ApplicationRecord
  belongs_to :user

  # TODO: monetize?
  def total_amount_due =
    total_amount_due_cents ?
      "%d.%02d" % [total_amount_due_cents / 100, total_amount_due_cents % 100] : ""
  
  def pdf_title = "invoice_#{date.strftime('%Y%m%d')}_#{id}.pdf"
end
