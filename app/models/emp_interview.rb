#coding: utf-8

class EmpInterview < ActiveRecord::Base
  belongs_to :emp_selection
  
  validates :time,
    :numericality => { 
        :allow_blank => true,
        :only_integer => true,
        :greater_than_or_equal_to => 0,
        :less_than => 10000 }
  
  validates :candidates,
    :numericality => { 
        :allow_blank => true,
        :only_integer => true,
        :greater_than_or_equal_to => 0,
        :less_than => 10000 }
  
  validates :examiners,
    :numericality => { 
        :allow_blank => true,
        :only_integer => true,
        :greater_than_or_equal_to => 0,
        :less_than => 10000 }
  
  validates :details,
    :length => { :maximum => 2000, :allow_blank => true,
                 :message => 'は2000文字以内にしてください'} 
        
end
