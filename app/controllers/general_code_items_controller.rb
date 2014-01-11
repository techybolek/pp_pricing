require 'pluck_all'
class GeneralCodeItemsController < ApplicationController
  def show
    items = GeneralCodeItem.where(:group_code => params[:id]).uniq
    items = items.order("short_description asc").pluck_all(:value, "short_description as text")
    render json: items
  end
end
