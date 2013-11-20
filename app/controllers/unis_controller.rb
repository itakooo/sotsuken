#coding: utf-8

#進学試験報告書に関するものを扱う
class UnisController < ApplicationController
  #編集を行う前に学籍番号がアカウントと一致するか確認する
  before_filter :check_editer, :only => ['edit','edit_impression']

  #進学試験報告書のトップページ
  # GET /unis
  # GET /unis.json
  def index
    @unis = Uni.order("created_at DESC").
      paginate(:page => params[:page], :per_page => 20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @unis }
    end
  end

  #進学試験報告書の詳細表示
  # GET /unis/1
  # GET /unis/1.json
  def show
    @uni = Uni.find(params[:id])
    # for Google Maps
    @json = @uni.to_gmaps4rails
    @interview_row = 3
    if @uni.uni_interview.examiners
      @interview_row = 4
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @uni }
    end
  end

  #新規進学試験報告書の基本情報の入力ページ作成
  # GET /unis/new
  # GET /unis/new.json
  def new
    @uni = Uni.new
    @uni.uni_submission = UniSubmission.new
    @uni.uni_app = UniApp.new
    @uni.uni_exam = UniExam.new
    @uni.uni_result = UniResult.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @uni }
    end
  end
  
  # 進学試験報告書基本情報の編集入力ページ(1/4)
  # GET /unis/1/edit
  def edit
    @uni = Uni.find(params[:id])
  end
  
  # 進学試験報告書感想の入力ページ
  # GET /edit_impression
  def edit_impression
    @uni = Uni.find(params[:id])
    #入力フォームの送信先をここで指定
    @form_to = update_impression_uni_path(params[:id])
  end
  
  # 進学試験報告書感想のデータベースに登録
  # POST /emps/update_impression
  def update_impression
    @uni = Uni.find(params[:id])
    @uni.attributes = params[:uni]
    
    respond_to do |format|
      if @uni.save
        #登録した内容を表示
        format.html { redirect_to @uni, notice: '登録が完了しました。' }
        format.json { head :no_content }
      else
        @form_to = update_impression_uni_path(params[:id])
        format.html { render action: "edit_impression" }
        format.json { render json: @uni.errors, status: :unprocessable_entity }
      end
    end
  end

  # 進学試験報告書の基本情報をデータベースに登録
  # POST /unis
  # POST /unis.json
  def create
    @uni = Uni.new(params[:uni])
    @uni.uni_submission = UniSubmission.new(params[:uni_submission])
    @uni.uni_app = UniApp.new(params[:uni_app])
    @uni.uni_exam = UniExam.new(params[:uni_exam])
    @uni.uni_result = UniResult.new(params[:uni_result])
    @uni.uni_result.uni = @uni
    @uni.uni_submission.uni = @uni
    @uni.uni_app.uni = @uni
    @uni.uni_exam.uni = @uni
    @uni.account = Account.find(session[:usr])

    @uni.valid?
    if(@uni.errors.any?)
      @error_flag = true
    end

    @uni.uni_submission.valid?
    if(@uni.uni_submission.errors.any?)
      @error_flag = true
    end

    respond_to do |format|
      if !@error_flag
        @uni.save
        #新規試験科目の登録ページに遷移させる
        format.html { redirect_to new_index_uni_uni_subjects_path(@uni)}
        format.json { render json: @uni, status: :created, location: @uni }
      else
        format.html { render action: "new" }
        format.json { render json: @uni.errors, status: :unprocessable_entity }
      end
    end
  end

  # 進学試験報告書の基本情報の編集内容をデータベースに保存
  # PUT /unis/1
  # PUT /unis/1.json
  def update
    @uni = Uni.find(params[:id])
    
    @uni.attributes = params[:uni]
    @uni.uni_submission.attributes = params[:uni_submission]
    @uni.uni_app.attributes = params[:uni_app]
    @uni.uni_exam.attributes = params[:uni_exam]
    @uni.uni_result.attributes = params[:uni_result]
    
    @uni.valid?
    if(@uni.errors.any?)
      @error_flag = true
    end
    
    @uni.uni_submission.valid?
    if(@uni.uni_submission.errors.any?)
      @error_flag = true
    end

    respond_to do |format|
      if !@error_flag  # エラーがない場合
        @uni.save
        @uni.uni_submission.save
        @uni.uni_app.save
        @uni.uni_exam.save
        @uni.uni_result.save
        # 試験科目の編集ページに遷移
        format.html { redirect_to edit_index_uni_uni_subjects_path(@uni)}
        format.json { head :no_content }
      else # エラーがある場合
        format.html { render action: "edit" }
        format.json { render json: @uni.errors, status: :unprocessable_entity }
      end
    end
  end

  # 報告書の削除、関連したデータベースの内容も
  # DELETE /unis/1
  # DELETE /unis/1.json
  def destroy
    @uni = Uni.find(params[:id])
    
    if(@uni.uni_submission != nil)
        @uni.uni_submission.destroy
    end
    if(@uni.uni_app != nil)
        @uni.uni_app.destroy
    end
    if(@uni.uni_exam != nil)
        @uni.uni_exam.destroy
    end
    
    @uni.uni_subjects.each do |sub|
        sub.destroy
    end
    
    if(@uni.uni_interview != nil)
        @uni.uni_interview.destroy
    end
        
    if(@uni.uni_result != nil)
        @uni.uni_result.destroy
    end
    
    @uni.destroy

    respond_to do |format|
      format.html { redirect_to unis_url }
      format.json { head :no_content }
    end
  end
  
  private
  #編集フィルター
  def check_editer
    @uni = Uni.find(params[:id])
    if @uni.account.id != session[:usr]
      redirect_to root_path
    end
  end
end
