class UpdateInvoices < ActiveRecord::Migration[7.0]
  def up
    change_table :invoices do |t|
      t.rename :invoice_number, :number
      t.rename :invoice_date, :date
      t.rename :total_amount_due, :total_amount_due_cents

      t.change :number, :string, null: false
      t.change :date, :date, null: false
      t.change :customer_name, :string, null: false
      t.change :total_amount_due_cents, :integer, null: false

      t.references :user, foreign_key: true, null: false
    end
  end

  def down
    change_table :invoices do |t|
      t.rename :number, :invoice_number
      t.rename :date, :invoice_date
      t.rename :total_amount_due_cents, :total_amount_due

      t.change :number, :string, null: true
      t.change :date, :date, null: true
      t.change :customer_name, :string, null: true
      t.change :total_amount_due, :float, null: true

      t.remove_references :user
    end
  end
end
