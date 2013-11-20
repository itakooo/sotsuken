#coding: utf-8
class EmpSubmission < ActiveRecord::Base
  belongs_to :emp
  
  validates :other,
		:length => { :maximum => 30, :minimum => 1,
                 :allow_blank => true}
  
end
