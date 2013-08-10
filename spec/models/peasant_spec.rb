require 'spec_helper'

describe Peasant do

  subject(:peasant){ Peasant.new }

  describe "#save" do

    before do
      peasant.save
    end

    it "makes user searchable" do
      SearchEngine.search(:user, user.email).should_not be_nil
    end

    it "sends notification emails" do
      # Do stuff here that makes sure email was sent
    end

    it "creates a single page pdf" do
      File.exists?(user.single_page_pdf_file_path).should be_true
      #what if single page pdfs are stored in S3?
    end
  end

end
