class ChangeDataTypeForDataChegada < ActiveRecord::Migration
  def up
  	change_column :conta, :data_chegada, :date
  	change_column :conta, :data_pagar, :date
  end

  def down
  	change_column :conta, :data_chegada, :datetime
  	change_column :conta, :data_pagar, :datetime
  end
end
