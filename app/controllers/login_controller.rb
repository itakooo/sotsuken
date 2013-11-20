#coding: utf-8

# ログインを扱うコントローラ
class LoginController < ApplicationController
    skip_before_filter :check_logined
    # 本のまんま
    def auth
        usr = Account.authenticate(params[:student], params[:password])
        if usr then
            session[:usr] = usr.id
            redirect_to params[:referer]
        else
            flash.now[:referer] = params[:referer]
            @error = 'ログインに失敗しました'
            render 'index'
        end
    end
    
    def logout
        reset_session
        redirect_to :controller => 'top', :action => 'index'
    end

end
