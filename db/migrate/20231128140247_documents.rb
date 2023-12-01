class Documents < ActiveRecord::Migration[7.1]
  def change
    create_table :documents do |t|
      t.string :title
      t.text :body
      t.string :attachment
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
