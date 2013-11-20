#coding: utf-8

class EmpSelection < ActiveRecord::Base
  belongs_to :emp
  has_one :emp_interview
  has_one :emp_essay
  has_one :emp_test
  
  validates :location,
    :length => { :maximum => 50, :allow_blank => true,
                 :message => 'は文字数は30文字以下にしてください'}
    
end
