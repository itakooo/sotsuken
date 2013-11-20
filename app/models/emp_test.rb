#coding: utf-8

class EmpTest < ActiveRecord::Base
  belongs_to :emp_selection
  
  validates :kind,
    :numericality => { :only_integer => true, :allow_blank => true,
                      :message => 'は整数値にしてください'}
  
  validates :details,
    :length => { :maximum => 2000, :allow_blank => true,
                 :message => 'は2000文字以内にしてください'}
end
