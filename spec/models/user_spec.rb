require 'rails_helper'

RSpec.describe User, type: :model do
   it 'é válido com factory' do
    expect(build(:user)).to be_valid
  end
end
