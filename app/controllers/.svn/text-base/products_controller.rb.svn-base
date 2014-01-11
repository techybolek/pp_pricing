class ProductsController < ApplicationController
 
  def index
    setup_sessions
    
    @products = Product.search(
      session[:product_filters].clone
    ).order(
      session[:product_filters][:order]
    ).page(
      params[:page]
    ).per(
      session[:product_filters][:amount]
    )
  end

  def edit
    # if version param is not supplied, fetch the newest version
    if params[:version].nil? || params[:version].empty?
      version = ProductVersion.where(product_code: params[:id]).maximum("product_version_code")
      redirect_to edit_product_path(params[:id], version: version )
      return 
    end
    
    @product = Product.get(params[:id], params[:version])
  end

  def synchronize
    @products = Product.search(
      session[:product_filters].clone
    ).order(
      session[:product_filters][:order]
    ).page(
      params[:page]
    ).per(
      session[:product_filters][:amount]
    )

    Tool.doUpload(@products)
    flash[:notice] = "Product catalog synchronized successfully"
    redirect_to products_path
  end
  
  protected
    def setup_sessions
      session[:product_filters] = params[:product_filters] || session[:product_filters] || {
        associated_service_code: '',
        associated_service_name: '',
        qualification_group_code: '',
        qualification_value: '',
        change_group_id: '',
        product_code: '',
        product_name: '',
        provider_code: '',
        test_mode_ind: '',
        amount: '10',
        search_all_versions: false
      }
      
      session[:product_filters][:order] = params[:order] || session[:product_filters][:order] || 'product_code asc'
    end
end
