class PricingStructuresController < ApplicationController
  
  def edit
    @structure = PricingStructure.where(
      pricing_structure_code: params[:id],
      product_code: params[:product],
      product_version_code: params[:version]
    ).first
  end
  
end
