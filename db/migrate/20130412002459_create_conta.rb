class CreateConta < ActiveRecord::Migration
  def change
    create_table :conta do |t|
      t.string :nome
      t.datetime :data_chegada
      t.datetime :data_pagar

      t.timestamps
    end
  end
end
