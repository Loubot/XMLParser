# == Schema Information
#
# Table name: favourites
#
#  id         :integer          not null, primary key
#  station    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Favourite < ActiveRecord::Base
  attr_accessible :station
  belongs_to :user
end
