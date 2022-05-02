module Invoices
  class List < ApplicationService
    def call(user:)
      Invoice
        .where(user:)
        .to_a
    end
  end
end
