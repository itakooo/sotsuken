#coding: utf-8

#就職試験報告書を扱うコントローラ
class EmpsController < ApplicationController
  #編集を行う前に学籍番号がアカウントと一致するか確認する
  before_filter :check_editer, :only => ['edit','edit_impression']
  
  #就職トップページ
  # GET /emps
  # GET /emps.json
  def index
    #報告書の作成日の新しい順に並べ替えて取得
    @emps = Emp.order("created_at DESC")
              .paginate(:page => params[:page], :per_page => 20)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @emps }
    end
  end

  # 報告書表示ページ
  # GET /emps/1
  # GET /emps/1.json
  def show
    @emp = Emp.find(params[:id])
    @interview_row = []
    @selection_row = []
    #表の表示を整えるため、行数を調べる。
    @emp.emp_selections.each do |selection|
      @row = 4
      
      if selection.emp_test.kind
        @row += 2
      end
      
      if selection.emp_interview.examiners
        @row += 4
        @interview_row.push(4)
      else
        @row += 3
        @interview_row.push(3)
      end
      
      @selection_row.push(@row)
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @emp }
    end
  end

  #就職試験報告書の基本情報新規入力ページ
  # GET /emps/new
  # GET /emps/new.json
  def new
    @emp = Emp.new
    @emp.emp_submission = EmpSubmission.new
    @emp.emp_briefing = EmpBriefing.new
    @emp.emp_webtest = EmpWebtest.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @emp }
    end
  end
  
  #就職試験報告書感想入力ページ
  #GET /emps/edit_impression
  def edit_impression
    @emp = Emp.find(params[:id])
    #入力フォームの送信先をここで指定
    @form_to = update_impression_emp_path(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @emp }
    end
  end
  
  #就職試験報告書基本情報編集入力ページ
  # GET /emps/1/edit
  def edit
    @emp = Emp.find(params[:id])
    
    respond_to do |format|
      format.html
      format.json { render json: @emp }
    end
  end
  
  #就職試験報告書感想をデータベースに登録
  # POST /emps/update_impression
  def update_impression
    #感想、アドバイス部分のみを変更するようにする。
    @emp = Emp.find(params[:id])
    @temp = Emp.new(params[:emp])
    @emp.impression = @temp.impression
    @emp.advice = @temp.advice
    respond_to do |format|
      if @emp.save
        format.html { redirect_to @emp, notice: '登録が完了しました。' }
        format.json { head :no_content }
      else
        format.html { render action: "edit_impression" }
        format.json { render json: @emp.errors, status: :unprocessable_entity }
      end
    end
  end
  
  #就職試験報告書基本情報をデータベースに登録
  #POST /emps
  def create
    @emp = Emp.new(params[:emp])
    @emp.emp_submission = EmpSubmission.new(params[:emp_submission])
    @emp.emp_briefing = EmpBriefing.new(params[:emp_briefing])
    @emp.emp_webtest = EmpWebtest.new(params[:emp_webtest])
    
    @emp.emp_submission.emp = @emp
    @emp.emp_briefing.emp = @emp
    @emp.emp_webtest.emp = @emp
    
    @emp.account = Account.find(session[:usr])
    
    @emp.valid?
    if(@emp.errors.any?)
      #エラー処理
      @error_flag = true
    end
    
    @emp.emp_submission.valid?
    if(@emp.emp_submission.errors.any?)
      #エラー処理
      @error_flag = true
    end
        
    @emp.emp_briefing.valid?
    if(@emp.emp_briefing.errors.any?)
      #エラー処理
      @error_flag = true
    end
    
    @emp.emp_webtest.valid?
    if(@emp.emp_webtest.errors.any?)
      #エラー処理
      @error_flag = true
    end
    
    respond_to do |format|
      #エラーがない場合保存
      if !@error_flag
        @emp.save
        format.html { redirect_to new_emp_emp_selection_path(@emp.id)}
        format.json { render json: @emp, status: :created, location: @emp }
      else
        format.html { render action: "new" }
        format.json { render json: @emp.errors, status: :unprocessable_entity }
      end
    end
  end

  #　就職試験報告書の基本情報編集内容をデータベースに登録
  # PUT /emps/1
  # PUT /emps/1.json
  def update
    @emp = Emp.find(params[:id])
    @emp.attributes = params[:emp]
    @emp.emp_submission.attributes = params[:emp_submission]
    @emp.emp_briefing.attributes = params[:emp_briefing]
    @emp.emp_webtest.attributes = params[:emp_webtest]
    
    @emp.emp_submission.emp = @emp
    @emp.emp_briefing.emp = @emp
    @emp.emp_webtest.emp = @emp
    
    @emp.valid?
    if(@emp.errors.any?)
      #エラー処理
      @error_flag = true
    end
    
    @emp.emp_submission.valid?
    if(@emp.emp_submission.errors.any?)
      #エラー処理
      @error_flag = true
    end
        
    @emp.emp_briefing.valid?
    if(@emp.emp_briefing.errors.any?)
      #エラー処理
      @error_flag = true
    end
    
    @emp.emp_webtest.valid?
    if(@emp.emp_webtest.errors.any?)
      #エラー処理
      @error_flag = true
    end
    
    respond_to do |format|
      if !@error_flag 
        @emp.save
        @emp.emp_submission.save
        @emp.emp_briefing.save
        @emp.emp_webtest.save
        format.html { redirect_to edit_index_emp_emp_selections_path(@emp)}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @emp.errors, status: :unprocessable_entity }
      end
    end
  end

  # 報告書の削除、関連したデータベースとともに
  # DELETE /emps/1
  # DELETE /emps/1.json
  def destroy
    @emp = Emp.find(params[:id])
    
    @selections = EmpSelection.where(:emp_id => @emp)
    @selections.each do |selection|
        if(selection.emp_interview != nil)
            selection.emp_interview.destroy
        end
        if(selection.emp_test != nil)
            selection.emp_test.destroy
        end
        if(selection.emp_essay != nil)
            selection.emp_essay.destroy
        end
        selection.destroy
    end
    
    if(@emp.emp_submission != nil)
        @emp.emp_submission.destroy
    end
    if(@emp.emp_briefing != nil)
        @emp.emp_briefing.destroy
    end
    if(@emp.emp_webtest != nil)
        @emp.emp_webtest.destroy
    end
    
    @emp.destroy

    respond_to do |format|
      format.html { redirect_to emps_url }
      format.json { head :no_content }
    end
  end
  
  #フィルターはプライベートで宣言
  private
  #編集する人が正しいか調べる
  def check_editer
    @emp = Emp.find(params[:id])
    if @emp.account.id != session[:usr]
      redirect_to root_path
    end
  end
  
end
