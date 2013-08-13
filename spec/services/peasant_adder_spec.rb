require 'spec_helper'

describe PeasantAdder do
  let(:addable) { Object.new }
  subject{ PeasantAdder.new(addable) }

  describe "#save" do
    context "invalid addable"  do

      before { addable.stub(:save).and_return(false) }

      it "call the APIs" do
        SearchEngine.should_not_receive(:index).with(addable)
        UserMailer.should_not_receive(:notify_user).with(addable)
        BackgroundWorker.should_not_receive(:pdf_job).with(addable)

        subject.save
      end
    end

    context "Valid addable" do

      before { addable.stub(:save).and_return(true) }

      it "should not call APIs" do
        SearchEngine.should_receive(:index).with(addable)
        UserMailer.should_receive(:notify_user).with(addable)
        PeasantPdfWriter.should_receive(:new).with(addable)

        subject.save
      end

    end
  end
end
