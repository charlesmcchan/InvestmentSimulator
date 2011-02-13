class Quote < ActiveRecord::Base
  has_many :quote_histories
end
