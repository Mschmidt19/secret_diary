require "secret_diary"
require "security"

describe Security do

  let(:security) { Security.new }


  describe "#unlock" do
    before do
      security.instance_variable_set(:@passphrase, "P@ssphras3!")
    end
    it { is_expected.to respond_to :unlock }
    context "passphrase entered correctly" do
      before do
        allow(STDIN).to receive(:gets).and_return("P@ssphras3!")
      end
      it "prints a statement stating that diary has been unlocked" do
        security.lock
        expect { security.unlock }.to output("Enter your passphrase\nDiary unlocked\n").to_stdout
      end
      it "unlocks the diary" do
        security.lock
        expect(security).to be_locked
        security.unlock
        expect(security).not_to be_locked
      end

    end
    context "passphrase entered incorrectly" do
      before do
        allow(STDIN).to receive(:gets).and_return("wrongpassphrase")
      end
      it "states that diary is already unlocked if it is" do
        expect { security.unlock }.to output("Diary already unlocked\n").to_stdout
      end
      it "raises an error stating passphrase is incorrect" do
        security.lock
        expect { security.unlock }.to raise_error("Incorrect passphrase")
      end
    end
  end

  describe "#lock" do
    it { is_expected.to respond_to :lock }
    context "no passphrase has been set," do
      context "passphrases match" do
        it "asks user to set and confirm a passphrase, then sets @passphrase" do
          allow(STDIN).to receive(:gets).and_return("P@ssphras3!", "P@ssphras3!")
          expect { subject.lock }.to output("Please set your passphrase\nPlease confirm your passphrase\nPassphrase has been set\nDiary locked\n").to_stdout
          expect(subject.passphrase).to eq "P@ssphras3!"

        end
      end
      context "passphrases do not match" do
        it "asks user to set and confirm a passphrase, then throws a mismatched passphrase error" do
          allow(STDIN).to receive(:gets).and_return("P@ssphras3!", "mismatch")
          expect { subject.lock }.to raise_error("Mismatched passphrase")
          expect(subject.passphrase).to be_nil
        end
      end
    end
    context "passphrase set" do
      before do
        security.instance_variable_set(:@passphrase, "P@ssphras3!")
      end
      it "states that diary is already locked if it is" do
        security.lock
        expect { security.lock }.to output("Diary already locked\n").to_stdout
      end
      it 'prints a statement stating that diary has been locked' do
        expect { security.lock }.to output("Diary locked\n").to_stdout
      end
      it "locks the diary" do
        security.lock
        expect(security).to be_locked
      end
    end
  end
end
