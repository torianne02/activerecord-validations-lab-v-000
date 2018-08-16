class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
  validate :is_clickbait

  @@clickbait = [/Won't Believe/i, /Secret/i, /Top [0-0]/i, /guess/i]

  def is_clickbait
    if !@@clickbait.any? {| word | word.match title}
      errors.add(:title, "not clickbait")
    end
  end
end
