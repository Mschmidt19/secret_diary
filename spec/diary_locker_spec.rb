require "diary_locker"

describe DiaryLocker do
  before do
    @diary = SecretDiary.new
    @dl = DiaryLocker.new
  end

  describe "#unlock" do
    it { is_expected.to respond_to(:unlock).with(1).argument }
    it "prints a statement stating that diary has been unlocked" do
      expect { subject.unlock(@diary) }.to output("Diary unlocked\n").to_stdout
    end
  end

  describe "#lock" do
    it { is_expected.to respond_to(:lock).with(1).argument }
    it 'prints a statement stating that diary has been locked' do
      expect { subject.lock(@diary) }.to output("Diary locked\n").to_stdout
    end
  end

end
