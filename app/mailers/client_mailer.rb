class ClientMailer < ActionMailer::Base

  default :from => "primeiro.direito@example.com"
 
  def sending_conta(client, conta)
  	   setup_email(client.email)
       @subject    = "Conta #{conta.nome}"
       @client = client
       @conta = conta
	   Thread.new do
	      mail(:to => client.email,
	          :subject => @subject).deliver
	   end
  end
 
  def registration_confirmation(client)
	  setup_email(client.email)
	  @subject    = "Obrigado por te Registares"
	  @client = client
	  Thread.new do
	      mail(:to => client.email,
	          :subject => @subject).deliver
	  end
end
 
protected
  def setup_email(mail)
	  @recipients   = "#{mail}"
	  @sent_on      = Time.now
	  @content_type = "text/html"
  end

end
