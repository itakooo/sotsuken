#coding: utf-8

#進学面接に関するコントローラ
class UniInterviewsController < ApplicationController
  #編集を行う前に学籍番号がアカウントと一致するか確認する
  before_filter :check_editer, :only => 'edit'
  
  # システムでは使わない
  # GET unis/1/uni_interviews
  # GET unis/1/uni_interviews.json
  def index
    @uni_interviews = UniInterview.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @uni_interviews }
    end
  end
  
  #システムでは使わない
  # GET unis/1/uni_interviews/1
  # GET unis/1/uni_interviews/1.json
  def show
    @uni_interview = UniInterview.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @uni_interview }
    end
  end

  # 面接を新規入力ページ
  # GET unis/1/uni_interviews/new
  # GET unis/1/uni_interviews/new.json
  def new
    #flash.keep(:edit_subject)
    @uni_interview = UniInterview.new
    #入力フォームの送信先をここで指定
    @form_to = uni_uni_interviews_path(params[:uni_id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @uni_interview }
    end
  end
  
  # 面接内容の編集入力ページ
  # GET unis/1/uni_interviews/1/edit
  def edit
    @uni = Uni.find(params[:uni_id])
    @uni_interview = @uni.uni_interview
    #入力フォームの送信先をここで指定
    @form_to = uni_uni_interview_path(@uni,@uni_interview)
  end

  # 面接の情報をデータベースに登録
  # POST unis/1/uni_interviews
  # POST unis/1/uni_interviews.json
  def create
    @uni_interview = UniInterview.new(params[:uni_interview])
    @uni = Uni.find(params[:uni_id])
    @uni_interview.uni = @uni
    
    respond_to do |format|
      if @uni_interview.save
        # #進学試験報告書の感想編集へ
        # format.html { redirect_to edit_impression_uni_path(@uni)}
        format.html { redirect_to new_uni_draw_path(@uni)}
        format.json { render json: @uni_interview, status: :created, location: @uni_interview }
      else
        #flash.keep(:edit_subject)
        @form_to = uni_uni_interviews_path(params[:uni_id])
        format.html { render action: "new" }
        format.json { render json: @uni_interview.errors, status: :unprocessable_entity }
      end
    end
  end

  # 面接の編集内容をデータベースに登録
  # PUT unis/1/uni_interviews/1
  # PUT unis/1/uni_interviews/1.json
  def update
    @uni = Uni.find(params[:uni_id])
    
    respond_to do |format|
      if @uni.uni_interview.update_attributes(params[:uni_interview])      
        #進学試験報告書の感想編集へ
        #format.html { redirect_to edit_impression_uni_path(@uni)}
        format.html { redirect_to edit_uni_draw_path(@uni) }
        format.json { head :no_content }
      else
        @form_to = uni_uni_interview_path(params[:uni_id],params[:id])
        format.html { render action: "edit" }
        format.json { render json: @uni_interview.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE unis/1/uni_interviews/1
  # DELETE unis/1/uni_interviews/1.json
  def destroy
    @uni_interview = UniInterview.find(params[:id])
    @uni_interview.destroy

    respond_to do |format|
      format.html { redirect_to uni_interviews_url }
      format.json { head :no_content }
    end
  end
  
  private
  def check_editer
    @uni = Uni.find(params[:uni_id])
    if @uni.account.id != session[:usr]
      redirect_to root_path
    end
  end
end
