class ClientsController < ApplicationController

  def show
  	@client = Client.find(params[:id])
  end

  def new
  	@client = Client.new
  end

  def create
  	@client = Client.new(params[:client])
  	if @client.save
  		flash[:success] = "Bem Vindo ao Meu Twitter!"
  		redirect_to @client 
  	else
  		render 'new'
  	end
  end


end
