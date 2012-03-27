class CreateDictionaryEntities < ActiveRecord::Migration
  def change
    create_table :dictionary_entities do |t|

      t.timestamps
    end
  end
end
