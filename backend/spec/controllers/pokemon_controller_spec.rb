require "rails_helper"

RSpec.describe Api::V1::PokemonController, type: :controller do
  describe 'Pokemon controller request specs' do

    before(:each) do
      @pokemon = Pokemon.create!(pokemon_attributes)
      expect(@pokemon).to be_instance_of(Pokemon)
    end

    context 'GET #index' do 
      it 'should success and render to index page' do
        get :index, format: :json
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body).length).to eq(1)
      end
    end

    context 'GET #show' do
      it 'should success and render' do
        get :show, params: { id: @pokemon.item_id, format: :json }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['name']).to eq(@pokemon.name )
      end
    end

    context 'POST #create' do
      it 'should success and create' do
        post :create, params: { id: @pokemon.item_id, format: :json, pokemon: pokemon_attributes.merge('name': 'test-create') }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['name']).to eq('test-create' )
      end
    end

    context 'PUT #update' do
      it 'should success and update' do
        put :update, params: { id: @pokemon.item_id, format: :json, pokemon: pokemon_attributes.merge('name': 'test-update') }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['name']).to eq('test-update' )
      end
    end

    context 'DELETE #destroy' do
      it 'should success and destroy' do
        delete :destroy, params: { id: @pokemon.item_id, format: :json }
        expect(response).to have_http_status(200)
        expect(Pokemon.only_deleted.map(&:name).sort).to eq([@pokemon.name])
      end
    end

  end
end
