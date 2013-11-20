#coding: utf-8

class Account < ActiveRecord::Base

	has_many :unis
	has_many :emps
	
	validates :student_id,
		:presence => { :message => 'は必須です'},
		:uniqueness => {:allow_blank => true,
                    :message => 'はすでに登録されている学籍番号です'},
		:length => { :is => 5, :allow_blank => true,
                    :message => 'は半角数字5文字で入力してください' },
		:format => { :with => /^[0-9]{5}$/, :allow_blank => true,
                    :message => 'は半角数字5文字で入力してください'}
	validates :name,
		:presence => { :message => 'は必須です' },
		:length => { :maximum => 30, :minimum => 1, :allow_blank => true,
                 :message => 'は文字数は30文字以下にしてください'}
	validates :major,
		:presence => true,
		:numericality => { :allow_blank => true,
            :only_integer => true, :greater_than => 0, :less_than => 6}
	validates :password,
		:presence => true,
    :confirmation => {:message => '入力が一致しません'}
		#:length => { :maximum => 16, :minimum => 4}

  def self.authenticate(student,password)
    where(:student_id => student,
        :password => Digest::SHA1.hexdigest(password)).first
  end
end
