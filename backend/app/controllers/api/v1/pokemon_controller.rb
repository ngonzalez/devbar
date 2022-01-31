class Api::V1::PokemonController < ApiController
  before_action :set_pokemon

  def index
    respond_to do |format|
      format.json do
        render json: @pokemon, each_serializer: PokemonSerializer,
          layout: false
      end
    end
  end

  private
  def permitted_params
    params.permit :format, :utf8
  end

  def set_pokemon
    @pokemon = Pokemon.all
  end
end
