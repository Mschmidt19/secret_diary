require "secret_diary"
require "security"

describe Security do

  let(:my_security) { double(:security, passphrase: "P@ssphras3!") }
  let(:my_diary) { double(:diary, security: my_security) }
  let(:new_diary) { Diary.new }

  describe "#lock" do
    it { is_expected.to respond_to :lock }
    context "no passphrase has been set" do
      it "asks user to set and confirm a passphrase" do
        expect(STDOUT).to receive(:puts).with("Please set your passphrase")
        allow(STDIN).to receive(:gets) { "P@ssphras3!" }
        expect(STDOUT).to receive(:puts).with("Please confirm your passphrase")
        allow(STDIN).to receive(:gets) { "P@ssphras3!" }
        expect(my_diary.security.passphrase).to eq "P@ssphras3!"
      end
    end
    context "passphrase set"
    it 'prints a statement stating that diary has been locked' do
      expect { my_security.lock }.to output("Diary locked\n").to_stdout
    end
  end

  describe "#unlock" do
    it { is_expected.to respond_to :unlock }
    context "passphrase entered correctly" do
      it "prints a statement stating that diary has been unlocked" do
        expect(STDOUT).to receive(:puts).with("Enter your passphrase")
        allow(STDIN).to receive(:gets) { "P@ssphras3!" }
        expect { my_security.unlock }.to output("Diary unlocked\n").to_stdout
      end
    end
    context "passphrase entered incorrectly" do
      it "raises an error stating passphrase is incorrect" do
        expect(STDOUT).to receive(:puts).with("Enter your passphrase")
        allow(STDIN).to receive(:gets) { "wrongpassphrase" }
        expect { my_security.unlock }.to raise_error("Incorrect passphrase")
      end
    end
  end

end
