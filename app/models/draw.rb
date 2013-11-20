# -*- coding: utf-8 -*-
class Draw < ActiveRecord::Base
  belongs_to :uni

  validates :txt,
  :length => { :maximum => 1000, :allow_blank => false,
    :message => '1000文字以下にしてください'}
    
end
