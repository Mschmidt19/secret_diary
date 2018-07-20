require "secret_diary"
require "security"

describe Security do

  let(:security) { Security.new }


  describe "#unlock" do
    it { is_expected.to respond_to :unlock }
    context "passphrase entered correctly" do
      before do
        allow(security).to receive(:passphrase).and_return("P@ssphras3!")
      end
      it "prints a statement stating that diary has been unlocked" do
        expect(STDOUT).to receive(:puts).with("Enter your passphrase")
        allow(STDIN).to receive(:gets) { "P@ssphras3!" }
        expect { security.unlock }.to output("Diary unlocked\n").to_stdout
      end
    end
    context "passphrase entered incorrectly" do
      it "raises an error stating passphrase is incorrect" do
        expect(STDOUT).to receive(:puts).with("Enter your passphrase")
        allow(STDIN).to receive(:gets) { "wrongpassphrase" }
        expect { security.unlock }.to raise_error("Incorrect passphrase")
      end
    end
  end

  # describe "#lock" do
  #   it { is_expected.to respond_to :lock }
  #   context "no passphrase has been set" do
  #     it "asks user to set and confirm a passphrase" do
  #       expect(STDOUT).to receive(:puts).with("Please set your passphrase")
  #       allow(STDIN).to receive(:gets) { "P@ssphras3!" }
  #       expect(STDOUT).to receive(:puts).with("Please confirm your passphrase")
  #       allow(STDIN).to receive(:gets) { "P@ssphras3!" }
  #       expect(new_diary.security.passphrase).to eq "P@ssphras3!"
  #     end
  #   end
  #   context "passphrase set"
  #   it 'prints a statement stating that diary has been locked' do
  #     expect { new_diary.security.lock }.to output("Diary locked\n").to_stdout
  #   end
  # end



end
