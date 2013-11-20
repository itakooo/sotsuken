#coding: utf-8

class UniSubject < ActiveRecord::Base
  belongs_to :uni

  validates :time,
    :numericality => {
        :allow_blank => true,
        :only_integer => true,
        :greater_than_or_equal_to => 0,
        :less_than => 10000 }

  validates :details,
    :length => { :maximum => 2000, :allow_blank => true}

  validates :subject,
		:presence => { :message => 'は必須です'},
		:length => { :maximum => 30, :minimum => 1, :allow_blank => true}
end
