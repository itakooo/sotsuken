#coding: utf-8

class UniSubmission < ActiveRecord::Base
  belongs_to :uni

  validates :other,
		:length => { :maximum => 30, :minimum => 1, :allow_blank => true}

  validates :reason_details,
    :length => { :maximum => 2000, :allow_blank => true,
                 :message => 'は2000文字以内にしてください'} 
end
