class Contum < ActiveRecord::Base
  belongs_to :client
  attr_accessible :data_chegada, :data_pagar, :nome, :valor_pagar

   def total_clients
    return Client.count
  end

  def valor_d_cada
  	if valor_pagar!=nil
		return (valor_pagar/total_clients)
	else
		valor_pagar=0
		return 0
	end
  end
end
