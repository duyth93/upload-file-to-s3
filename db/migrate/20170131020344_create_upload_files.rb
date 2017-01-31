class CreateUploadFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :upload_files do |t|
      t.string :filename
      t.string :filepath
      t.integer :filesize

      t.timestamps null: false
    end
  end
end
