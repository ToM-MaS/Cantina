class VcardsController < ApplicationController
  # GET /vcards
  # GET /vcards.xml
  def index
    @vcards = Vcard.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @vcards }
    end
  end

  # GET /vcards/1
  # GET /vcards/1.xml
  def show
    @vcard = Vcard.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vcard }
    end
  end

  # GET /vcards/new
  # GET /vcards/new.xml
  def new
    @vcard = Vcard.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vcard }
    end
  end

  # GET /vcards/1/edit
  def edit
    @vcard = Vcard.find(params[:id])
  end

  # POST /vcards
  # POST /vcards.xml
  def create
    @vcard = Vcard.new(params[:vcard])

    respond_to do |format|
      if @vcard.save
        format.html { redirect_to(@vcard, :notice => 'Vcard was successfully created.') }
        format.xml  { render :xml => @vcard, :status => :created, :location => @vcard }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @vcard.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /vcards/1
  # PUT /vcards/1.xml
  def update
    @vcard = Vcard.find(params[:id])

    respond_to do |format|
      if @vcard.update_attributes(params[:vcard])
        format.html { redirect_to(@vcard, :notice => 'Vcard was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vcard.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /vcards/1
  # DELETE /vcards/1.xml
  def destroy
    @vcard = Vcard.find(params[:id])
    @vcard.destroy

    respond_to do |format|
      format.html { redirect_to(vcards_url) }
      format.xml  { head :ok }
    end
  end
end
