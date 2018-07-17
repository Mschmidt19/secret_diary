require "secret_diary"

describe SecretDiary do
  before do
    @diary = SecretDiary.new
    @dl = DiaryLocker.new
  end

  describe "#initialize" do
    it "initializes diaries in a locked state" do
      expect(subject).to be_locked
    end
  end

  describe "#add_entry" do
    it { is_expected.to respond_to(:add_entry).with(1).argument }
    context "when locked" do
      it "raises an error if diary is locked" do
        expect { @diary.add_entry("Hello") }.to raise_error("You must unlock the diary before entering")
      end
      it "raises an error if diary is locked after having been unlocked" do
        @dl.unlock(@diary)
        @diary.add_entry("Hello!")
        @dl.lock(@diary)
        expect { @diary.add_entry("Hello") }.to raise_error("You must unlock the diary before entering")
      end
    end
    context "when unlocked" do
      before do
        @dl.unlock(@diary)
      end
      it "adds string passed to entries array" do
        @diary.add_entry("Hello Diary")
        expect(@diary.entries).to include("Hello Diary")
      end
    end
  end

  describe "#get_entries" do
    it { is_expected.to respond_to :get_entries }
    context "when locked" do
      it "raises an error if diary is locked" do
        expect { @diary.get_entries }.to raise_error("You must unlock the diary before getting entries")
      end
      it "raises an error if diary is locked after having been unlocked" do
        @dl.unlock(@diary)
        @diary.get_entries
        @dl.lock(@diary)
        expect { @diary.get_entries }.to raise_error("You must unlock the diary before getting entries")
      end
    end
    context "when unlocked" do
      before do
        @dl.unlock(@diary)
      end
      it "prints a list of all entries to console in a neat way" do
        @diary.add_entry("Hello Diary")
        expect { @diary.get_entries }.to output("1. Hello Diary\n").to_stdout
        @diary.add_entry("Goodbye Diary")
        expect { @diary.get_entries }.to output("1. Hello Diary\n2. Goodbye Diary\n").to_stdout
      end
    end
  end
end
