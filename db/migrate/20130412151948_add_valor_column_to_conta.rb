class AddValorColumnToConta < ActiveRecord::Migration
  def change
    add_column :conta, :valor_pagar, :float
  end
end
