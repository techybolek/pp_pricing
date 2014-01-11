class GeneralCodeItem < ActiveRecord::Base
  self.table_name = :general_code_item

  def self.lookup(group_code, value)
    where(:group_code => group_code, :value => value).first
  end

  def as_json(*args)
    super.tap { |hash| hash["text"] = hash.delete "short_description" }
  end
end
