class CreateNeedImages < ActiveRecord::Migration[5.0]
  def change
    create_table :need_images do |t|
      t.string :caption
      t.references :need, foreign_key: true

      t.timestamps
    end
  end
end
