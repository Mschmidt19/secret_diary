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
        expect { security.unlock }.to output("Enter your passphrase\nDiary unlocked\n").to_stdout
      end
    end
    context "passphrase entered incorrectly" do
      before do
        allow(STDIN).to receive(:gets).and_return("wrongpassphrase")
      end
      it "raises an error stating passphrase is incorrect" do
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
          subject.lock
          expect(subject.passphrase).to eq "P@ssphras3!"
          expect { subject.lock }.to output("Diary locked\n").to_stdout
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
    context "passphrase set"
    before do
      security.instance_variable_set(:@passphrase, "P@ssphras3!")
    end
    it 'prints a statement stating that diary has been locked' do
      expect { security.lock }.to output("Diary locked\n").to_stdout
    end
  end



end
