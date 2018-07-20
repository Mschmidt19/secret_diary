class Security
  def initialize
    @locked = false
  end

  attr_reader :passphrase

  def unlock
    if @locked == false
      puts "Diary already unlocked"
      return
    end
    puts "Enter your passphrase"
    enteredphrase = STDIN.noecho(&:gets).chomp
    fail "Incorrect passphrase" unless enteredphrase == @passphrase
    @locked = false
    puts "Diary unlocked"
  end

  def lock
    if @locked == true
      puts "Diary already locked"
      return
    end
    secure! if @passphrase == nil
    @locked = true
    puts "Diary locked"
  end

  def locked?
    @locked
  end

  private
  def secure!
    puts "Please set your passphrase"
    enteredphrase = STDIN.noecho(&:gets).chomp
    puts "Please confirm your passphrase"
    confirmedphrase = STDIN.noecho(&:gets).chomp
    fail "Mismatched passphrase" unless enteredphrase == confirmedphrase
    @passphrase = enteredphrase
    puts "Passphrase has been set"
  end
end
