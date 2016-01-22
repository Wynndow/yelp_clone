require 'spec_helper'

describe Endorsement, type: :model do

  it { should belong_to(:review) }
  
end
