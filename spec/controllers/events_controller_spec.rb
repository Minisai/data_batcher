require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:valid_attributes) do
    {
      event: 'event123'
    }
  end

  let(:invalid_attributes) do
    {
      event: ''
    }
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Event' do
        expect do
          post :create, params: valid_attributes
        end.to change(EventRecord, :count).by(1)
      end

      it 'renders a JSON response with the new event' do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new event' do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
