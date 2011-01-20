class PhoneKeyFunctionDefinitionsController < ApplicationController
  # GET /phone_key_function_definitions
  # GET /phone_key_function_definitions.xml
  def index
    @phone_key_function_definitions = PhoneKeyFunctionDefinition.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @phone_key_function_definitions }
    end
  end

  # GET /phone_key_function_definitions/1
  # GET /phone_key_function_definitions/1.xml
  def show
    @phone_key_function_definition = PhoneKeyFunctionDefinition.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @phone_key_function_definition }
    end
  end

  # GET /phone_key_function_definitions/new
  # GET /phone_key_function_definitions/new.xml
  def new
    @phone_key_function_definition = PhoneKeyFunctionDefinition.new
    
    @phone_key_function_definition_type_of_classes = [ 'string', 'integer', 'boolean', 'url', 'uri' ]
    @default_for_select_phone_key_function_definition_type_of_class = 'string'
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @phone_key_function_definition }
    end
  end

  # GET /phone_key_function_definitions/1/edit
  def edit
    @phone_key_function_definition = PhoneKeyFunctionDefinition.find(params[:id])
    
    @phone_key_function_definition_type_of_classes = [ 'string', 'integer', 'boolean', 'url', 'uri' ]
    @default_for_select_phone_key_function_definition_type_of_class = @phone_key_function_definition.type_of_class
  end

  # POST /phone_key_function_definitions
  # POST /phone_key_function_definitions.xml
  def create
    @phone_key_function_definition = PhoneKeyFunctionDefinition.new(params[:phone_key_function_definition])

    respond_to do |format|
      if @phone_key_function_definition.save
        format.html { redirect_to(@phone_key_function_definition, :notice => 'Phone key function definition was successfully created.') }
        format.xml  { render :xml => @phone_key_function_definition, :status => :created, :location => @phone_key_function_definition }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @phone_key_function_definition.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /phone_key_function_definitions/1
  # PUT /phone_key_function_definitions/1.xml
  def update
    @phone_key_function_definition = PhoneKeyFunctionDefinition.find(params[:id])

    respond_to do |format|
      if @phone_key_function_definition.update_attributes(params[:phone_key_function_definition])
        format.html { redirect_to(@phone_key_function_definition, :notice => 'Phone key function definition was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @phone_key_function_definition.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /phone_key_function_definitions/1
  # DELETE /phone_key_function_definitions/1.xml
  def destroy
    @phone_key_function_definition = PhoneKeyFunctionDefinition.find(params[:id])
    @phone_key_function_definition.destroy

    respond_to do |format|
      format.html { redirect_to(phone_key_function_definitions_url) }
      format.xml  { head :ok }
    end
  end
end
