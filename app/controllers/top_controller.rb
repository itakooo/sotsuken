#coding utf-8

#トップに関するコントローラ
class TopController < ApplicationController
    skip_before_filter :check_logined
    
    def index
        respond_to do |format|
            format.html # index.html.erb
        end
    end
      
end
