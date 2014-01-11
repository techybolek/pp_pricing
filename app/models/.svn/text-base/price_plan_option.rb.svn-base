class PricePlanOption < ActiveRecord::Base
  self.table_name = :price_plan_option
  
  def self.for_price_plan_version(price_plan_version_id)
    select("ppo.option_name, ppov.option_value_name")
    .from("price_plan pp
            join price_plan_option ppo
              on pp.price_plan_version_id = ppo.price_plan_version_id
            join price_plan_option_value ppov
              on ppo.price_plan_option_value_id = ppov.price_plan_option_value_id")
    .where("pp.price_plan_version_id = :price_plan_version_id", {:price_plan_version_id => price_plan_version_id})
  end
end