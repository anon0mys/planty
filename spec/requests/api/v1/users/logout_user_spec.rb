require 'rails_helper'

describe 'Delete /api/v1/users/logout' do
  let(:user) { create(:user) }

  context 'as a signed in user' do
    before { sign_in(user) }
    before { delete destroy_user_session_path, headers: @auth_headers }

    it 'should return a message' do
      data = JSON.parse(response.body)
      
      expect(data['message']).to eq 'Succesfully logged out'
    end
  end

  context 'as a visitor' do
    before { delete destroy_user_session_path }

    it 'should return a message' do
      data = JSON.parse(response.body)

      expect(data['message']).to eq 'Succesfully logged out'
    end
  end
end