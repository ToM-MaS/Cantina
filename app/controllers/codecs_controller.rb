class CodecsController < ApplicationController
  # GET /codecs
  # GET /codecs.xml
  def index
    @codecs = Codec.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @codecs }
    end
  end

  # GET /codecs/1
  # GET /codecs/1.xml
  def show
    @codec = Codec.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @codec }
    end
  end

  # GET /codecs/new
  # GET /codecs/new.xml
  def new
    @codec = Codec.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @codec }
    end
  end

  # GET /codecs/1/edit
  def edit
    @codec = Codec.find(params[:id])
  end

  # POST /codecs
  # POST /codecs.xml
  def create
    @codec = Codec.new(params[:codec])

    respond_to do |format|
      if @codec.save
        format.html { redirect_to(@codec, :notice => 'Codec was successfully created.') }
        format.xml  { render :xml => @codec, :status => :created, :location => @codec }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @codec.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /codecs/1
  # PUT /codecs/1.xml
  def update
    @codec = Codec.find(params[:id])

    respond_to do |format|
      if @codec.update_attributes(params[:codec])
        format.html { redirect_to(@codec, :notice => 'Codec was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @codec.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /codecs/1
  # DELETE /codecs/1.xml
  def destroy
    @codec = Codec.find(params[:id])
    @codec.destroy

    respond_to do |format|
      format.html { redirect_to(codecs_url) }
      format.xml  { head :ok }
    end
  end
end
