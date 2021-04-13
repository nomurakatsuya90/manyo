class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :expired_at, presence: true
  validates :status, presence: true
  validates :priority, presence: true

  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings

  enum status: { '未着手': 0, '着手中': 1, '完了': 2 }
  enum priority: { '低': 0, '中': 1, '高': 2}

  scope :title_search, -> (title){where('title LIKE ?', "%#{title}%")}
  scope :status_search, -> (status){
                                      if status == '未着手'  
                                        where(status: 0)
                                      elsif status == '着手中'
                                        where(status: 1)
                                      elsif status == '完了'
                                        where(status: 2)
                                      end
                                    }
end
