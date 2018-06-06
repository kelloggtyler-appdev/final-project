# == Schema Information
#
# Table name: blocks
#
#  id         :integer          not null, primary key
#  start_date :date
#  end_date   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  number     :integer
#  year       :integer
#

class Block < ApplicationRecord
end
