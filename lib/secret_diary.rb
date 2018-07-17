class SecretDiary
  def initialize
    @locked = true
    @entries = []
  end
  def add_entry(string)
    fail "You must unlock the diary before entering" if locked?
    @entries.push(string)
  end
  def get_entries
    fail "You must unlock the diary before getting entries" if locked?
    @entries.each_with_index do |entry, index|
      puts "#{index + 1}. #{entry}"
    end
  end
  def locked?
    if @locked == false
      false
    elsif @locked == true
      true
    end
  end
  attr_accessor :locked
  attr_reader :entries
end
