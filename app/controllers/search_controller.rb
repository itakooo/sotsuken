#coding: utf-8

#検索に関するコントローラ
class SearchController < ApplicationController
  #検索トップページ
  def index
    respond_to do |format|
      format.html # index.html.erb      
    end
  end
  
  #就職検索フォームを表示
  def emp
    
  end
  
  #進学検索フォームを表示
  def uni
  
  end
  
  #就職検索フォームの入力内容を取得し、結果を表示
  def result_emp
    if !params[:commit].blank?
      @name = params[:name]
      session[:name] = @name
      @location = params[:location]
      session[:location] = @location
      if params[:glouping] == "suisen"
        @glouping = true
      elsif params[:glouping] == "jiyu"
        @glouping = false
      end
      session[:glouping]
    else
      @name = session[:name]
      @location = session[:location]
      @glouping = session[:glouping]
    end
    
    if @glouping != nil
      @emps = Emp.where("name LIKE ? AND location LIKE ? AND glouping == ?",
        "%#{@name}%","%#{@location}%",@glouping).
        order("created_at DESC").paginate(:page => params[:page],:per_page => 20)
    else
      @emps = Emp.where("name LIKE ? AND location LIKE ?",
        "%#{@name}%","%#{@location}%").
        order("created_at DESC").paginate(:page => params[:page],:per_page => 20)
    end
    #render :text => params[:glouping]
    render :action => "result_emp"
  end
  
  #進学検索フォームの入力内容を取得し、結果を表示
  def result_uni
    if !params[:commit].blank?
      @name = params[:name]
      session[:name] = @name
      @location = params[:location]
      session[:location] = @location
      if params[:glouping] == "suisen"
        @glouping = true
      elsif params[:glouping] == "jiyu"
        @glouping = false
      end
      session[:glouping]
      @key_subjects = params[:subjects]
      session[:subjects] = @key_subjects
      @major = params[:major]
      session[:major] = @major
    else
      @name = session[:name]
      @location = session[:location]
      @glouping = session[:glouping]
      @key_subjects = session[:subjects]
      @major = session[:major]
    end
    
    if @glouping != nil
      @unis = Uni.where("name LIKE ? AND location LIKE ? AND glouping == ? AND major LIKE ?",
        "%#{@name}%","%#{@location}%",@glouping,"%#{@major}%").
        order("created_at DESC").paginate(:page => params[:page],:per_page => 20)
    else
      @unis = Uni.where("name LIKE ? AND location LIKE ? AND major LIKE ?",
        "%#{@name}%","%#{@location}%","%#{@major}%").
        order("created_at DESC").paginate(:page => params[:page],:per_page => 20)
    end
    
    #科目名でOR検索
    if !@key_subjects.blank?
      #全角スペースを半角スペースに変換後、文字列を半角スペースで分割し配列に格納
      @key_subjects_array = @key_subjects.gsub(/　/," ").split(" ")
      @subject_ids = []
      #他の検索条件で引っかかった報告書のそれぞれに対して以下の処理を行う
      @unis.each do |uni|
        @flag = false
        uni.uni_subjects.each do |sub|
          @key_subjects_array.each do |key_sub|
            if sub.subject.index(key_sub) != nil
              @flag = true
            end
          end
        end
        if @flag
          @subject_ids << uni.id
        end
      end
      @unis = Uni.where(:id => @subject_ids).
        order("created_at DESC").paginate(:page => params[:page],:per_page => 20)
    end
    #render json: @subject_ids
    render :action => "result_uni"
  end

end
