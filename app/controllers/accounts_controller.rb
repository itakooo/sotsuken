#coding: utf-8

class AccountsController < ApplicationController
  #ログインチェックフィルターを一部でスキップする
  skip_filter :check_logined, :only => ['new','show','create']
  #編集を行う前に学籍番号がアカウントと一致するか確認する
  before_filter :check_editer, :only => 'edit'

  #マイページの表示
  # GET /accounts/mypage
  def mypage
    @account = Account.find(session[:usr])
    @emps = Emp.where("account_id == ?",session[:usr]).
        order("created_at DESC").paginate(:page => params[:page],:per_page => 20)
    @unis = Uni.where("account_id == ?",session[:usr]).
        order("created_at DESC").paginate(:page => params[:page],:per_page => 20)
  end

  #アカウント一覧
  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @accounts }
    end
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    @account = Account.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @account }
    end
  end

  # GET /accounts/new
  # GET /accounts/new.json
  def new
    @account = Account.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @account }
    end
  end

  # GET /accounts/1/edit
  def edit
    @account = Account.find(params[:id])
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(params[:account])
    #パスワードはハッシュ化して登録
    @account.password = Digest::SHA1.hexdigest(@account.password)
    @account.password_confirmation = Digest::SHA1.hexdigest(@account.password_confirmation)
    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'アカウントが正常に作成されました。' }
        format.json { render json: @account, status: :created, location: @account }
      else
        format.html { render action: "new" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /accounts/1
  # PUT /accounts/1.json
  def update
    @account = Account.find(params[:id])
    @account.attributes = params[:account]
    @account.password = Digest::SHA1.hexdigest(@account.password)
    @account.password_confirmation = Digest::SHA1.hexdigest(@account.password_confirmation)
    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'アカウントが正常に更新されました。' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account = Account.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to accounts_url }
      format.json { head :no_content }
    end
  end
  
  private
  def check_editer
    @account = Account.find(params[:id])
    if @account.id != session[:usr]
      redirect_to root_path
    end
  end
  
end
