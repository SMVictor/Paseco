class BncrInfo < ApplicationRecord
  
  def self.complete_amount(amount)
    if amount.length > 12 then amount = amount[0..11] end
    amount = "0" * (12 - amount.length) + amount
  end

  def self.complete_voucher_number(amount)
    amount = "0" * (8 - amount.length) + amount
  end

  def self.create_concept(concept, name)
    concept = (concept + " " + name).upcase.gsub!(/[^A-Za-z0-9]/, ' ' => ' ')
  end

  def self.complete_amount_end(amount)
    amount = "0" * (15 - amount.length) + amount
  end

  def self.comple_accounts(amount)
    amount = "0" * (10 - amount.length) + amount
  end
end
