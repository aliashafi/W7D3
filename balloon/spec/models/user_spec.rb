require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) {User.create!(username: 'aliashafi', password:'123456')}

  describe 'validations' do
    it {should validate_presence_of(:username)}
    it {should validate_presence_of(:password_digest)}
    it {should validate_presence_of(:session_token)}
    it {should validate_length_of(:password).is_at_least(6).allow_nil}
    it {should validate_uniqueness_of(:username)}
    it {should validate_uniqueness_of(:session_token)}
  end

  describe '::find_by_credentials' do
    it 'should find user by credentials' do
      expect(User.find_by_credentials('aliashafi', '123456')).to_not be(nil)
    end
    
  end

end
