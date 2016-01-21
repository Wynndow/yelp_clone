require 'rails_helper'

describe User do

  it { should have_many(:restaurants) }

  it { should have_many(:reviews) }

  it { should have_many :reviewed_restaurants }

end
