# -*- coding: utf-8 -*-
class DrawsController < ApplicationController

  #編集を行う前に学籍番号がアカウントと一致するか確認する
  before_filter :check_editer, :only => 'edit'

  # GET /draws
  # GET /draws.json
  # def index
  #   @draws = Draw.all

  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.json { render json: @draws }
  #   end
  # end

  # GET /draws/11
  # GET /draws/1.json
  def show
    @draw = Draw.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @draw }
    end
  end

  # GET /draws/new
  # GET /draws/new.json
  def new
    @draw = Draw.new

    @form_to = uni_draws_path(params[:uni_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @draw }
    end
  end

  # GET /draws/1/edit
  def edit
    @uni = Uni.find(params[:uni_id])
    @draw = @uni.draw
    @form_to = uni_draw_path(@uni, @draw)
  end

  # POST /draws
  # POST /draws.json
  def create
    @draw = Draw.new(params[:draw])
    @uni = Uni.find(params[:uni_id])
    @draw.uni = @uni

    respond_to do |format|
      if @draw.save
        format.html { redirect_to edit_impression_uni_path(@uni)}
        format.json { render json: @draw, status: :created, location: @draw }
      else
        @form_to = uni_draws_path(params[:uni_id])
        format.html { render action: "new" }
        format.json { render json: @draw.errors, status: :unprocessable_entity }
      end
    end
  end

  # 新規登録 POST
  def update
    @uni = Uni.find(params[:uni_id])

    respond_to do |format|
      if @uni.draw.update_attributes(params[:draw])
        format.html { redirect_to edit_impression_uni_path(@uni)}
        format.json { head :no_content }
      else
        @form_to = uni_draw_path(params[:uni_id], params[:id])
        format.html { render action: "edit" }
        format.json { render json: @draw.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /draws/1
  # DELETE /draws/1.json
  def destroy
    @draw = Draw.find(params[:id])
    @draw.destroy

    respond_to do |format|
      format.html { redirect_to draws_url }
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
