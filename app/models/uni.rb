#coding: utf-8

class Uni < ActiveRecord::Base
  belongs_to :account     # アカウント
  has_one :uni_app        # ?
  has_one :uni_result     # 結果
  has_one :uni_exam       # 試験期間
  has_one :uni_submission # 願書提出期間
  has_many :uni_subjects  # 試験科目(複数)
  has_one :uni_interview  # 進学面接
  has_one :draw
  attr_accessible :location, :gmaps, :latitude, :longitude, :name, :major, :glouping, :impression, :advice

  acts_as_gmappable

  validates :name,
		:presence => { :message => 'は必須です' },
		:length => { :maximum => 30, :minimum => 1, :allow_blank => true,
                 :message => 'は文字数は30文字以下にしてください'}

  validates :major,
  	:presence => { :message => 'は必須です' },
		:length => { :maximum => 30, :minimum => 1, :allow_blank => true,
                 :message => 'は文字数は30文字以下にしてください'}

  validates :location,
    :presence => { :message => 'は必須です' },
		:length => { :maximum => 50, :minimum => 1, :allow_blank => true,
                 :message => 'は文字数は50文字以下にしてください'}

  validates :impression,
    :length => { :maximum => 2000, :allow_blank => true,
                 :message => 'は2000文字以内にしてください'}

  validates :advice,
    :length => { :maximum => 2000, :allow_blank => true,
                 :message => 'は2000文字以内にしてください'}

  # アドレス生成に使うカラムを指定
  def gmaps4rails_address
    "#{self.location}"
  end

  # インフォウィンドウ
  def gmaps4rails_infowindow
    "<h3>#{self.name}</h3><h5>#{self.location}</h5>"
  end
end
