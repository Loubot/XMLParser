# == Schema Information
#
# Table name: favourites
#
#  id         :integer          not null, primary key
#  station    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)
#

require 'spec_helper'

describe Favourite do
  pending "add some examples to (or delete) #{__FILE__}"
end
