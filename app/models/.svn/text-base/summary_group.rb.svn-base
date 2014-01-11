class SummaryGroup < ActiveRecord::Base
  self.primary_key = :summary_group_id
  self.table_name = :summary_group
  
  def self.for_summary_group_id(id)
    select("sa.attribute_id, sa.name")
    .from("summary_group_component sgc
             join summary_attribute sa
               on sgc.attribute_id = sa.attribute_id")
    .where("sgc.summary_group_id = :summary_group_id", { :summary_group_id => id})
  end
end