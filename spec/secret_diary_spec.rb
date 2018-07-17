require "secret_diary"

describe SecretDiary do
  before do
    @diary = SecretDiary.new
  end

  describe "#initialize" do
    it "initializes diaries in a locked state" do
      expect(subject).to be_locked
    end
  end

  describe "#unlock" do
    it { is_expected.to respond_to :unlock }
    it "prints a statement stating that diary has been unlocked" do
      expect { subject.unlock }.to output("Diary unlocked\n").to_stdout
    end
  end

  describe "#lock" do
    it { is_expected.to respond_to :lock }
    it 'prints a statement stating that diary has been locked' do
      expect { subject.lock }.to output("Diary locked\n").to_stdout
    end
  end

  describe "#add_entry" do
    it { is_expected.to respond_to(:add_entry).with(1).argument }
    it "raises an error if diary is locked" do
      expect { @diary.add_entry("Hello") }.to raise_error("You must unlock the diary before entering")
    end
    it "raises an error if diary is locked after having been unlocked" do
      @diary.unlock
      @diary.add_entry("Hello!")
      @diary.lock
      expect { @diary.add_entry("Hello") }.to raise_error("You must unlock the diary before entering")
    end
    it "adds string passed to entries array" do
      @diary.unlock
      @diary.add_entry("Hello Diary")
      expect(@diary.entries).to include("Hello Diary")
    end
  end

  describe "#get_entries" do
    it { is_expected.to respond_to :get_entries }
    it "raises an error if diary is locked" do
      expect { @diary.get_entries }.to raise_error("You must unlock the diary before getting entries")
    end
    it "raises an error if diary is locked after having been unlocked" do
      @diary.unlock
      @diary.get_entries
      @diary.lock
      expect { @diary.get_entries }.to raise_error("You must unlock the diary before getting entries")
    end
    it "prints a list of all entries to console in a neat way" do
      @diary.unlock
      @diary.add_entry("Hello Diary")
      expect { @diary.get_entries }.to output("1. Hello Diary\n").to_stdout
      @diary.add_entry("Goodbye Diary")
      expect { @diary.get_entries }.to output("1. Hello Diary\n2. Goodbye Diary\n").to_stdout
    end
  end
end
