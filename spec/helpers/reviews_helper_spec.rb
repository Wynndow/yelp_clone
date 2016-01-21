require 'rails_helper'

describe ReviewsHelper, :type => :helper do
  context '#star_rating' do
    it 'does nothing for not a number' do
      expect(helper.star_rating('N/A')).to eq 'N/A'
    end

    it 'return five black stars for five' do
      expect(helper.star_rating(5)).to eq '★★★★★'
    end

    it 'returns three black stars and two white stars for three' do
      expect(helper.star_rating(3)).to eq '★★★☆☆'
    end

    it 'returns four black stars and one white star for 3.5' do
      expect(helper.star_rating(3.5)).to eq '★★★★☆'
    end
  end

  context '#time_created' do
    it 'returns "1 hour ago" for a review left an hour ago' do
      Timecop.travel(-60*60) do
        review = Review.create(rating: 4)
      end
      expect(helper.time_created(Review.first)).to eq 'about 1 hour ago'
    end

    it 'returns "2 hours ago" for a review left 2 hours ago' do
      Timecop.travel(-60*60*2) do
        review = Review.create(rating: 4)
      end
      expect(helper.time_created(Review.first)).to eq 'about 2 hours ago'
    end

    it 'returns "Less than an hour ago" for a review created less 30 mins ago' do
      Timecop.travel(-60*29) do
        review = Review.create(rating: 4)
      end
      expect(helper.time_created(Review.first)).to eq 'less than an hour ago'
    end

  end
end
