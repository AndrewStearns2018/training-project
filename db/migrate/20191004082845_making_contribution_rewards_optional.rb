class MakingContributionRewardsOptional < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:contributions, :reward_id, true)
  end
end
