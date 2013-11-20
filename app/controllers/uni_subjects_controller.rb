#coding: utf-8

#進学試験報告書の試験科目を扱うコントローラ
class UniSubjectsController < ApplicationController
  
  #編集を行う前に学籍番号がアカウントと一致するか確認する
  before_filter :check_editer, :only => 'edit_index'
  before_filter :check_editer_subject, :only => 'edit'

  #システムでは使わない
  # GET unis/1/uni_subjects
  # GET unis/1/uni_subjects.json
  def index
    @uni_subjects = UniSubject.all
    @uni = params[:uni_id]
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @uni_subjects }
    end
  end

  #システムでは使わない
  # GET unis/1/uni_subjects/1
  # GET unis/1/uni_subjects/1.json
  def show
    @uni_subject = UniSubject.find(params[:id])
    flash.keep(:edit_subject)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @uni_subject }
    end
  end
    
  #報告書に登録されているいる試験科目一覧
  # GET unis/1/uni_subjects/1
  def new_index
    @uni = Uni.find(params[:uni_id])
    
  end
  
  # 進学試験報告書の試験科目登録フォーム
  # GET unis/1/uni_subjects/new
  # GET unis/1/uni_subjects/new.json
  def new
    @uni_subject = UniSubject.new
    @form_to = uni_uni_subjects_path(params[:uni_id])
    flash.keep(:edit_subject)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @uni_subject }
    end
  end
  
  # 報告書に登録されている試験科目の一覧ページ
  # GET /unis/1/uni_subjects/edit_index
  def edit_index
    @uni = Uni.find(params[:uni_id])
    flash[:edit_subject] = 1
  end

  # 試験科目編集フォーム
  # GET unis/1/uni_subjects/1/edit
  def edit
    @uni_subject = UniSubject.find(params[:id])
    @form_to = uni_uni_subject_path(params[:uni_id],params[:id])
    flash.keep(:edit_subject)
  end

  # 試験科目をデータベースに新規登録
  # POST unis/1/uni_subjects
  # POST unis/1/uni_subjects.json
  def create
    @uni_subject = UniSubject.new(params[:uni_subject])
    @uni_subject.uni = Uni.find(params[:uni_id])
    
    respond_to do |format|
      if @uni_subject.save
            if(!flash[:edit_subject])
                #試験科目一覧に遷移
                format.html { redirect_to new_index_uni_uni_subjects_path(params[:uni_id])}
                format.json { render json: @uni_subject, status: :created, location: @uni_subject }
            else
                format.html { redirect_to edit_index_uni_uni_subjects_path(params[:uni_id])}
            end
      else
        flash.keep(:edit_subject)
        @form_to = uni_uni_subjects_path(params[:uni_id])
        format.html { render action: "new" }
        format.json { render json: @uni_subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # 試験科目の編集内容をデータベースに登録
  # PUT /uni_subjects/1
  # PUT /uni_subjects/1.json
  def update
    @uni_subject = UniSubject.find(params[:id])
    
    respond_to do |format|
      if @uni_subject.update_attributes(params[:uni_subject])
            if(!flash[:edit_subject])
                #試験科目一覧に遷移
                format.html { redirect_to new_index_uni_uni_subjects_path(params[:uni_id])}
                format.json { render json: @uni_subject, status: :created, location: @uni_subject }
            else
                format.html { redirect_to edit_index_uni_uni_subjects_path(params[:uni_id])}
            end
      else
        flash.keep(:edit_subject)
        @form_to = uni_uni_subject_path(params[:uni_id],params[:id])
        format.html { render action: "edit" }
        format.json { render json: @uni_subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE unis/1/uni_subjects/1
  # DELETE unis/1/uni_subjects/1.json
  def destroy
    @uni_subject = UniSubject.find(params[:id])
    flash.keep(:edit_subject)
    
    if(@uni_subject != nil)
        @uni_subject.destroy
    end

    respond_to do |format|
        if(flash[:edit_subject])
            format.html { redirect_to edit_index_uni_uni_subjects_path(params[:uni_id]) }
            format.json { head :no_content }
        else
            format.html { redirect_to new_index_uni_uni_subjects_path(params[:uni_id]) }
        end
    end
  end
  
  private
  def check_editer
    @uni = Uni.find(params[:uni_id])
    if @uni.account.id != session[:usr]
      redirect_to root_path
    end
  end
  
  def check_editer_subject
    @uni_subject = UniSubject.find(params[:id])
    if @uni_subject.uni.account.id != session[:usr]
      redirect_to root_path
    end
  end 
end
