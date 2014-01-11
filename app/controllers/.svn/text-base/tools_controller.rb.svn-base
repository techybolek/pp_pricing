class ToolsController < ApplicationController
  
  def upload
    Tool.doUpload
    #Savon.client File.expand_path('/sf.wsdl', __FILE__)
    flash[:notice] = "Product catalog uploaded successfully"
    redirect_to root_path
  end

  def wsdl
  end
  
end
