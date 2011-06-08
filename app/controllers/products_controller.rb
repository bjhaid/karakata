class ProductsController < ApplicationController
  #load_and_authorize_resource :only => [:edit, :destroy]
  #before_filter :authenticate_user!, :except => [:index, :show] 
  # GET /products
  # GET /products.xml
  def index
    @search = Product.search(params[:search])  
    @products = @search.order("id DESC").paginate(:per_page => 10, :page => params[:page])

    respond_to do |format|
      if @search.nil?
        flash[:notice] = "No search matches your criteria."
      else
        format.js
        format.html # index.html.erb
        format.xml  { render :xml => @products }
      end
    end
  end

   # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])
    @photos = @product.assets
    @comment = Comment.new(:product_id => @product.id)
  end 

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new
    5.times { @product.assets.build }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    5.times { @product.assets.build }
  end

  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(params[:product])
    @product = (user_signed_in? ? current_user.products.build(params[:product]) : Product.new(params[:product]))

      if @product.save
        flash[:notice] = 'Product was successfully posted.'
        redirect_to @product
      else
        render :action => "new"
      end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to(@product, :notice => 'Product was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
   def destroy
    @product = Product.find(params[:id])
    @comments = @product.comments
    @product.destroy
    @comments.destroy


     respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end
  
end
