#coding: utf-8

class Emp < ActiveRecord::Base
  belongs_to :account
  
  has_one :emp_briefing
  has_one :emp_submission
  has_one :emp_webtest
  has_many :emp_selections
  
  validates :name,
    :presence => { :message => 'は必須です' },
		:length => { :maximum => 30, :minimum => 1, :allow_blank => true,
                 :message => 'は文字数は30文字以下にしてください'}
  
  validates :location,
    :presence => { :message => 'は必須です' },
		:length => { :maximum => 50, :minimum => 1, :allow_blank => true,
                 :message => 'は文字数は50文字以下にしてください'}
  
  #validates :glouping,
    #:presence => { :message => 'は必須です' }
                 
  validates :entrysheet,
    :length => { :maximum => 2000, :allow_blank => true,
                 :message => 'は2000文字以内にしてください'}
                 
  validates :impression,
    :length => { :maximum => 2000, :allow_blank => true,
                 :message => 'は2000文字以内にしてください'}
                 
  validates :advice,
    :length => { :maximum => 2000, :allow_blank => true,
                 :message => 'は2000文字以内にしてください'} 
end
