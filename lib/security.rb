class Security
  def initialize
    @locked = false
  end
  attr_accessor :passphrase
  def unlock
    puts "Enter your passphrase"
    enteredphrase = STDIN.noecho(&:gets).chomp
    # puts "hello"
    puts enteredphrase
    puts @passphrase
    # fail "Incorrect passphrase" unless enteredphrase == @passphrase
    if enteredphrase == @passphrase
      @locked = false
      puts "Diary unlocked"
    else
      puts "Incorrect passphrase"
    end
  end

  def lock
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
