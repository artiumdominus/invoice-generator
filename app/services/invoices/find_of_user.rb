module Invoices
  class FindOfUser < ApplicationService
    def call(user:, id:)
      invoice = user.invoices.find(id)
    
      { ok: { invoice: } }
    rescue ActiveRecord::RecordNotFound
      { error: :invoice_of_user_not_found }
    end
  end
end
