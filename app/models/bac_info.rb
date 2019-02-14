class BacInfo < ApplicationRecord

  def self.complete_firts(data)
    data += " " * (30 - data.length)
  end

  def self.complete_total(data)
    data = "0" * (13 - data.length) + data
  end

  def self.complete_total_records(data)
    data = "0" * (5 - data.length) + data
  end

  def self.complete_index(data)
    data = "0" * (5 - data.length) + data
  end

  def self.complete_concept(data)
    data += " " * (31 - data.length)
  end

  def self.fix_name(data)
  	data = data.upcase.gsub!(/[^A-Za-z0-9]/, ' ' => ' ')
  end

end
