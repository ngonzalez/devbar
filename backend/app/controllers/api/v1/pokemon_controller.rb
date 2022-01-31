class Api::V1::PokemonController < ApiController
  before_action :set_collection, only: [:index]
  before_action :set_pokemon, only: [:show, :update, :destroy]
  before_action :create_pokemon, only: [:create]
  before_action :update_pokemon, only: [:update]
  before_action :destroy_pokemon, only: [:destroy]

  def index
    respond_to do |format|
      format.json do
        render json: @pokemon, each_serializer: PokemonSerializer,
          layout: false
      end
    end
  end

  def show
    respond_to do |format|
      format.json do
        render json: @pokemon, each_serializer: PokemonSerializer,
          layout: false
      end
    end
  end

  def create
    respond_to do |format|
      format.json do
        render json: @pokemon, each_serializer: PokemonSerializer,
          layout: false
      end
    end
  end

  def update
    respond_to do |format|
      format.json do
        render json: @pokemon, each_serializer: PokemonSerializer,
          layout: false
      end
    end
  end

  def destroy
    respond_to do |format|
      format.json do
        render json: {}, each_serializer: PokemonSerializer,
          layout: false
      end
    end
  end

  private

  def set_collection
    @pokemon = Pokemon.all
  end

  def set_pokemon
    @pokemon = Pokemon.find_by(item_id: params[:id])
  end

  def create_pokemon
    @pokemon = Pokemon.create!(permitted_params[:pokemon])
  end

  def update_pokemon
    @pokemon.update!(permitted_params[:pokemon])
  end

  def destroy_pokemon
    @pokemon.destroy
  end

  def permitted_params
    params.permit(:format, :utf8, :pokemon => [:item_id, :name, :type_1, :type_2,
                                               :total, :hp, :attack, :defense,
                                               :sp_atk, :sp_def, :speed,
                                               :generation, :legendary])
  end
end
