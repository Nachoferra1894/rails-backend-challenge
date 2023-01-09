class CreateSentMails < ActiveRecord::Migration[7.0]
  def change
    create_table :sent_mails do |t|
      t.references :user, null: false, foreign_key: true
      t.string :receiver
      t.text :subject
      t.text :body

      t.timestamps
    end
  end
end
