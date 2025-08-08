module Multipliable
  extend ActiveSupport::Concern

  def multiplier
    region.multiplier
  end
end
