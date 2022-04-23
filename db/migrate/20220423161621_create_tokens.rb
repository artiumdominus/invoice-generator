class CreateTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :tokens, id: :uuid do |t|
      t.boolean :active, null: false, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
      t.datetime :activated_at
      t.datetime :last_login
    end
  end
end
