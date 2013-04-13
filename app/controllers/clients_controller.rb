class ClientsController < ApplicationController

  before_filter :signed_in_client, only: [:index,:edit, :update]
  before_filter :correct_client, only: [:edit, :update]
  before_filter :admin_client, only: :destroy

  def index
    @clients = Client.paginate(page: params[:page])
  end

  def show
  	@client = Client.find(params[:id])
  end

  def new
  	@client = Client.new
  end

  def create
  	@client = Client.new(params[:client])
  	if @client.save
      sign_in @client
      ClientMailer.registration_confirmation(@client)
  		flash[:success] = "Bem Vindo ao Primeiro Direito!"
  		redirect_to @client 
  	else
  		render 'new'
  	end
  end

  def edit
  
  end

  def update
    @client = Client.find(params[:id])
    if @client.update_attributes(params[:client])
        sign_in @client
        flash[:success] = "Quarto Arrumado!"
        redirect_to @client 
    else
      render 'edit'
    end
  end

  def destroy
    Client.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to clients_path
  end

 

  private
    def signed_in_client
      unless  signed_in?
        store_location
        # flash[:notice] = "Por favor, Sign in!" fazer notice: "Por favor, Sign in!" é a mesma coisa
        redirect_to signin_path, notice: "Por favor, entra em casa!" 
      end
        
    end

    def correct_client
      @client = Client.find(params[:id])
      redirect_to root_path unless current_client?(@client)
    end
        
    def admin_client
      redirect_to root_path unless current_client.admin?
    end

end