class ChangeGroup < ActiveRecord::Base
  self.table_name = :change_group
  self.primary_key = :group_code_id
end
