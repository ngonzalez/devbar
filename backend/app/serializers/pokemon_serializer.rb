class PokemonSerializer < ActiveModel::Serializer
  attributes :id, :name, :type_1, :type_2, :total, :hp, :attack, :defense, :sp_atk, :sp_def, :speed, :generation, :legendary
  def id
    object.item_id
  end
end
