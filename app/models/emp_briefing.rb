#coding: utf-8

class EmpBriefing < ActiveRecord::Base
  belongs_to :emp
  
  validates :location,
		:length => { :maximum => 50, :minimum => 1, :allow_blank => true,
                 :message => 'は文字数は50文字以下にしてください'}
                 
  validates :details,
    :length => { :maximum => 2000, :allow_blank => true,
                 :message => 'は2000文字以内にしてください'}
end
