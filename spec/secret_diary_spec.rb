require "secret_diary"
require "stringio" # For stubbing gets.chomp

describe SecretDiary do

  let(:diary)                   { SecretDiary.new(security_class)                 }
  let(:security_class)          { double :security_class, new: security_instance  }
  let(:security_instance)       { double :security_instance                       }

  let(:time)                    { Time.now                                        }

  before do
    allow(Time).to receive(:now).and_return(time)
  end

  describe "#add_entry" do
    it { is_expected.to respond_to(:add_entry).with(1).argument }
    context "when locked" do
      before do
        allow(diary). to receive(:locked?).and_return(true)
      end
      it "raises an error if diary is locked" do
        expect { diary.add_entry("Hello") }.to raise_error("You must unlock the diary before entering")
      end
    end
    context "when unlocked" do
      before do
        allow(diary). to receive(:locked?).and_return(false)
      end
      it "adds hash with :date = time.now and :entry = the string passed to entries array" do
        diary.add_entry("Hello Diary")
        expect(diary.entries).to include({:date=>time, :entry=>"Hello Diary"})
      end
    end
  end

  describe "#get_entries" do
    it { is_expected.to respond_to :get_entries }
    context "when locked" do
      before do
        allow(diary). to receive(:locked?).and_return(true)
      end
      it "raises an error if diary is locked" do
        expect { diary.get_entries }.to raise_error("You must unlock the diary before getting entries")
      end
    end
    context "when unlocked" do
      before do
        allow(diary). to receive(:locked?).and_return(false)
      end
      it "prints a list of all entries to console in a neat way" do
        diary.add_entry("Hello Diary")
        expect { diary.get_entries }.to output("1. #{time}: Hello Diary\n").to_stdout
        diary.add_entry("Goodbye Diary")
        expect { diary.get_entries }.to output("1. #{time}: Hello Diary\n2. #{time}: Goodbye Diary\n").to_stdout
      end
    end
  end

  describe "#lock" do
    it "delegates locking to security instance" do
      expect(security_instance).to receive(:lock)
      diary.lock
    end
  end

  describe "#unlock" do
    it "delegates unlocking to security instance" do
      expect(security_instance).to receive(:unlock)
      diary.unlock
    end
  end

  describe "#locked?" do
    it "delegates checking locked state to security instance" do
      expect(security_instance).to receive(:locked?)
      diary.locked?
    end
  end

end
