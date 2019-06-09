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

  def self.complete_identification(data)
    if data.length < 10
      data = "0" * (10 - data.length) + data
    else
      data = data
    end
  end

  def self.complete_concept(data)
    if data.length < 31
      data += " " * (31 - data.length)
    else
      data = data[0, 30] + " "
    end
  end

  def self.fix_name(data)
  	data = data.upcase.gsub!(/[^A-Za-z0-9]/, ' ' => ' ')
  end

end
