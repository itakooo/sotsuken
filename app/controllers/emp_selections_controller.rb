#coding: utf-8

class EmpSelectionsController < ApplicationController
  #編集を行う前に学籍番号がアカウントと一致するか確認する
  before_filter :check_editer, :only => 'edit'
  
  # 一覧表示、使わない
  # GET /emps/1/emp_selections
  # GET /emps/1/emp_selections.json
  def index
    @emp_selections = EmpSelection.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @emp_selections }
    end
  end
  
  #使わない
  # GET /emps/1/emp_selections/1
  # GET /emps/1/emp_selections/1.json
  def show
    @emp_selection = EmpSelection.find(params[:id])
    flash.keep(:edit_selection)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @emp_selection }
    end
  end
  
  # 報告書に登録されている選考を一覧で表示するページ
  # GET /emps/1/emp_selections/new_index
  def new_index
    @emp = Emp.find(params[:emp_id])
  end
  
  # 選考新規追加入力ページ
  # GET emps/1/emp_selections/new
  # GET emps/1/emp_selections/new.json
  def new
    @emp_selection = EmpSelection.new
    @emp_selection.emp_interview = EmpInterview.new
    @emp_selection.emp_test = EmpTest.new
    @emp_selection.emp_essay = EmpEssay.new
    
    @form_to = emp_emp_selections_path(params[:emp_id])
    flash.keep(:edit_selection)
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @emp_selection }
    end
  end

  # 報告書に登録されている選考を一覧で表示するページ編集用
  # GET emps/1/emp_selections/1/edit_index/
  def edit_index
    @emp = Emp.find(params[:emp_id])
    flash[:edit_selection] = 1
  end
  
  # 選考の編集入力ページ
  # GET emps/1/emp_selections/1/edit
  def edit
    flash.keep(:edit_selection)
    @emp_selection = EmpSelection.find(params[:id])
    @form_to = emp_emp_selection_path(params[:emp_id])
  end
  
  # 選考をデータベースに登録
  # POST /emp_selections
  # POST /emp_selections.json
  def create
    
    @emp_selection = EmpSelection.new(params[:emp_selection])
    @emp_selection.emp_test = EmpTest.new(params[:emp_test])
    @emp_selection.emp_essay = EmpEssay.new(params[:emp_essay])
    @emp_selection.emp_interview = EmpInterview.new(params[:emp_interview])
    
    #関連付け
    @emp_selection.emp = Emp.find(params[:emp_id])
    @emp_selection.emp_test.emp_selection = @emp_selection
    @emp_selection.emp_essay.emp_selection = @emp_selection
    @emp_selection.emp_interview.emp_selection = @emp_selection
    
    @emp_selection.valid?
    if(@emp_selection.errors.any?)
      #エラー処理
      @error_flag = true
    end
    
    @emp_selection.emp_test.valid?
    if(@emp_selection.emp_test.errors.any?)
      #エラー処理
      @error_flag = true
    end
    
    @emp_selection.emp_essay.valid?
    if(@emp_selection.emp_essay.errors.any?)
      #エラー処理
      @error_flag = true
    end

    @emp_selection.emp_interview.valid?
    if(@emp_selection.emp_interview.errors.any?)
      #エラー処理
      @error_flag = true
    end
  
    respond_to do |format|
      if(!@error_flag)
        @emp_selection.save
        if(!flash[:edit_selection])
            # 就職試験報告書の選考一覧ページに遷移
            format.html { redirect_to new_index_emp_emp_selections_path(params[:emp_id]) }
            format.json { render json: @emp_selection, status: :created, location: @emp_selection }
        else
            format.html { redirect_to edit_index_emp_emp_selections_path(params[:emp_id]) }
            format.json { render json: @emp_selection, status: :created, location: @emp_selection }
        end
      else
        @form_to = emp_emp_selections_path(params[:emp_id])
        format.html { render action: "new" }
        format.json { render json: @emp_selection.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # 選考の編集内容をデータベースに登録
  # PUT /emp_selections/1
  # PUT /emp_selections/1.json
  def update
    @emp_selection = EmpSelection.find(params[:id])
    @emp_selection.attributes = params[:emp_selection]
    @emp_selection.emp_interview.attributes = params[:emp_interview]
    @emp_selection.emp_test.attributes = params[:emp_test]
    @emp_selection.emp_essay.attributes = params[:emp_essay]
    
    @emp_selection.emp = Emp.find(params[:emp_id])
    @emp_selection.emp_interview.emp_selection = @emp_selection
    @emp_selection.emp_test.emp_selection = @emp_selection
    @emp_selection.emp_essay.emp_selection = @emp_selection
    
    @emp_selection.valid?
    if(@emp_selection.errors.any?)
      #エラー処理
      @error_flag = true
    end
    
    @emp_selection.emp_test.valid?
    if(@emp_selection.emp_test.errors.any?)
      #エラー処理
      @error_flag = true
    end
    
    @emp_selection.emp_essay.valid?
    if(@emp_selection.emp_essay.errors.any?)
      #エラー処理
      @error_flag = true
    end

    @emp_selection.emp_interview.valid?
    if(@emp_selection.emp_interview.errors.any?)
      #エラー処理
      @error_flag = true
    end
    
    respond_to do |format|
      if !@error_flag 
        @emp_selection.save
        @emp_selection.emp_test.save
        @emp_selection.emp_essay.save
        @emp_selection.emp_interview.save
        
        if(!flash[:edit_selection])
            format.html { redirect_to new_index_emp_emp_selections_path(params[:emp_id]) }
            format.json { render json: @emp_selection, status: :created, location: @emp_selection }
        else
            format.html { redirect_to edit_index_emp_emp_selections_path(params[:emp_id]) }
            format.json { render json: @emp_selection, status: :created, location: @emp_selection }
        end
      else
        @form_to = emp_emp_selection_path(params[:emp_id])
        format.html { render "edit" }
        format.json { render json: @emp_selection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emp_selections/1
  # DELETE /emp_selections/1.json
  def destroy
    @emp_selection = EmpSelection.find(params[:id])
    @emp_selection.destroy
    flash.keep(:edit_selection)
    respond_to do |format|
      if(!session[:edit_selection])
        format.html { redirect_to new_index_emp_emp_selections_path(params[:emp_id]) }
      else
        format.html { redirect_to edit_index_emp_emp_selections_path(params[:emp_id]) }
      end
      format.json { head :no_content }
    end
  end
  
  #編集者チェックフィルター
  private
  def check_editer
    @emp_selection = EmpSelection.find(params[:id])
    if @emp_selection.emp.account.id != session[:usr]
      redirect_to root_path
    end
  end
end
