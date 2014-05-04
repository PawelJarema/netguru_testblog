class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  field :body, type: String
  field :title, type: String
  field :archived, type: Boolean, default: false

  validates_presence_of :body, :title

  belongs_to :user
  has_many :comments

  default_scope ->{ ne(archived: true) }

  def archive!
    update_attribute :archived, true
  end

  def friendly_date
    created_at.strftime("%d/%m/%Y : %H:%M")
  end

  def hotness
    hotness = 0
    hotness = 1 if created_at >= 7.days.ago
    hotness = 2 if created_at >= 72.hours.ago
    hotness = 3 if created_at >= 24.hours.ago
    hotness += 1 if comments.length >= 3
    hotness
  end

end
