class Restaurant < ActiveRecord::Base
  validates :name, length: {minimum: 3}, uniqueness: true
  has_many :reviews,
    -> { extending WithUserAssociationExtension },
    dependent: :destroy
  belongs_to :user

  has_attached_file :image, styles: { medium: "300x300>", :thumb => "100x100>"}, default_url: "/images/:style/missing.gif"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def build_review(attributes = {}, user)
    review = reviews.build(attributes)
    review.user = user
    review
  end

  def average_rating
    return 'N/A' if reviews.none?
    reviews.average(:rating).to_f.round(1)
  end

end
