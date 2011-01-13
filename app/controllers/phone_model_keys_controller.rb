class PhoneModelKeysController < ApplicationController
  # GET /phone_model_keys
  # GET /phone_model_keys.xml
  def index
    @phone_model_keys = PhoneModelKey.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @phone_model_keys }
    end
  end

  # GET /phone_model_keys/1
  # GET /phone_model_keys/1.xml
  def show
    @phone_model_key = PhoneModelKey.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @phone_model_key }
    end
  end

  # GET /phone_model_keys/new
  # GET /phone_model_keys/new.xml
  def new
    @phone_model_key = PhoneModelKey.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @phone_model_key }
    end
  end

  # GET /phone_model_keys/1/edit
  def edit
    @phone_model_key = PhoneModelKey.find(params[:id])
  end

  # POST /phone_model_keys
  # POST /phone_model_keys.xml
  def create
    @phone_model_key = PhoneModelKey.new(params[:phone_model_key])

    respond_to do |format|
      if @phone_model_key.save
        format.html { redirect_to(@phone_model_key, :notice => 'Phone model key was successfully created.') }
        format.xml  { render :xml => @phone_model_key, :status => :created, :location => @phone_model_key }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @phone_model_key.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /phone_model_keys/1
  # PUT /phone_model_keys/1.xml
  def update
    @phone_model_key = PhoneModelKey.find(params[:id])

    respond_to do |format|
      if @phone_model_key.update_attributes(params[:phone_model_key])
        format.html { redirect_to(@phone_model_key, :notice => 'Phone model key was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @phone_model_key.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /phone_model_keys/1
  # DELETE /phone_model_keys/1.xml
  def destroy
    @phone_model_key = PhoneModelKey.find(params[:id])
    @phone_model_key.destroy

    respond_to do |format|
      format.html { redirect_to(phone_model_keys_url) }
      format.xml  { head :ok }
    end
  end
end
