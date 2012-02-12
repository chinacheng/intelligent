class CreateRelatives < ActiveRecord::Migration
  def change
    create_table :relatives do |t|

      t.timestamps
    end
  end
end
