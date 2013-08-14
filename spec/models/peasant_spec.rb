require 'spec_helper'

describe Peasant do

  subject(:peasant){ described_class.new }

  describe "#save" do

    before do
      peasant.save
    end

    it "makes user searchable" do
      SearchEngine.search(:peasant, peasant.email).should_not be_nil
    end

    it "sends notification emails" do
      pending 'write code here that checks the mailer queue'
      # Do stuff here that makes sure email was sent
    end

    it "creates a single page pdf" do
      pending 'write code here that checks if the attachment is in S3'
      # Do stuff here that checks the Background worker's queue list and see if 
      # a job for the new peasant is there
    end
  end

end
