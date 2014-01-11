class PricingStructureQual < ActiveRecord::Base
  self.table_name = "pricing_structure_qual"
  
  def self.for_pricing_structure(pricing_structure_code, product_code, product_version_code)
    select(
      "pricing_structure_qual.*, psqv.description as qualification_group_name,
      gci.short_description as qualification_value_name"
    ).where(
      product_code: product_code,
      product_version_code: product_version_code,
      pricing_structure_code: pricing_structure_code
    ).joins(
      "left outer join ps_qual_value psqv
         on pricing_structure_qual.qualification_group_code = psqv.code_rd
       left outer join general_code_item gci
         on pricing_structure_qual.qualification_group_code = gci.group_code
         and pricing_structure_qual.qualification_value = gci.value"
    )
  end
end
