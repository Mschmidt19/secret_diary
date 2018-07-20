require_relative 'security'
require 'date'
require 'io/console'
class SecretDiary
  def initialize(security_class = Security)
    @entries = []
    @security = security_class.new
  end
  attr_reader :entries
  # attr_reader :security
  def add_entry(string)
    fail "You must unlock the diary before entering" if locked?
    @entries.push({:date => Time.now, :entry => string})
  end
  def get_entries
    fail "You must unlock the diary before getting entries" if locked?
    @entries.each_with_index do |entry, index|
      puts "#{index + 1}. #{entry[:date]}: #{entry[:entry]}"
    end
  end
  def lock
    @security.lock
  end
  def unlock
    @security.unlock
  end
  def locked?
    @security.locked?
  end
end
