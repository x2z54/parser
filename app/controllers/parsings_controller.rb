require 'nokogiri'         
require 'open-uri'

class ParsingsController < ApplicationController
  # GET /parsings
  # GET /parsings.json
  def index
    @parsings = Parsing.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @parsings }
    end
  end

  # GET /parsings/1
  # GET /parsings/1.json
  def show
    @parsing = Parsing.find(params[:id])

    @page = Nokogiri::HTML(open(@parsing.link))
    @number = @parsing.num.to_i
    i=0
    @string = ""
    @number.to_i.times do
        title = @page.css('div.item-list_info')[i].css('h4').text
        params =  @page.css('div.item-list_info')[i].css('ul').text.gsub(/\s+/, " ")
        price =  @page.css('div.item-list_info')[i].css('p.price').css('span.bold').text.gsub(/\s+/, "").to_i
        img = @page.css('div.photo_border_corners')[i].css('img')[0]
        @link_img = img['src']
        new_price = price - (price / 100 * 10)
        @string += "</br> #{title} #{params} #{new_price.to_s} p. <img src=' http://www.lepnina.ru/#{@link_img}'> </br>"
        #@string += "</br>" + title + params  + new_price.to_s + " p." + "<img src=' http://www.lepnina.ru/#{@link_img}'>" + "</br>"
        i+=1
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @parsing }
    end
  end

  # GET /parsings/new
  # GET /parsings/new.json
  def new
    @parsing = Parsing.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @parsing }
    end
  end

  # GET /parsings/1/edit
  def edit
    @parsing = Parsing.find(params[:id])
  end

  # POST /parsings
  # POST /parsings.json
  def create
    @parsing = Parsing.new(params[:parsing])
    respond_to do |format|
      if @parsing.save
        format.html { redirect_to @parsing, notice: 'Parsing was successfully created.' }
        format.json { render json: @parsing, status: :created, location: @parsing }
      else
        format.html { render action: "new" }
        format.json { render json: @parsing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /parsings/1
  # PUT /parsings/1.json
  def update
    @parsing = Parsing.find(params[:id])

    respond_to do |format|
      if @parsing.update_attributes(params[:parsing])
        format.html { redirect_to @parsing, notice: 'Parsing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @parsing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parsings/1
  # DELETE /parsings/1.json
  def destroy
    @parsing = Parsing.find(params[:id])
    @parsing.destroy

    respond_to do |format|
      format.html { redirect_to parsings_url }
      format.json { head :no_content }
    end
  end
end
