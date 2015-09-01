require "spec_helper"

describe Autoreply::Scanner::Headers::ByValue do
  let(:default_email_headers) {
    { 
      to: "to@example.com",
      from: "from@example.com",
      subject: "Example subject",
      body: "Example body"
    }
  }

  describe "#autoreply?" do
    it "should be false" do
      mail = Mail.new(default_email_headers)

      expect(described_class.new(mail.header_fields).autoreply?).to be_falsey
    end

    context "autoreplies" do
      it "should detect `x-spam-flag` header" do
        mail = Mail.new(default_email_headers.merge("x-spam-flag" => "yes"))

        expect(described_class.new(mail.header_fields).autoreply?).to be_truthy
      end

      it "should detect `x-spam-status` header" do
        mail = Mail.new(default_email_headers.merge("x-spam-status" => "yes"))

        expect(described_class.new(mail.header_fields).autoreply?).to be_truthy
      end

      it "should detect `x-spam-flag2` header" do
        mail = Mail.new(default_email_headers.merge("x-spam-flag2" => "yes"))

        expect(described_class.new(mail.header_fields).autoreply?).to be_truthy
      end

      it "should detect `precedence` header" do
        mail = Mail.new(default_email_headers.merge("precedence" => "bulk"))

        expect(described_class.new(mail.header_fields).autoreply?).to be_truthy
      end

      it "should detect `precedence` header" do
        mail = Mail.new(default_email_headers.merge("precedence" => "junk"))

        expect(described_class.new(mail.header_fields).autoreply?).to be_truthy
      end

      it "should detect `precedence` header" do
        mail = Mail.new(default_email_headers.merge("precedence" => "list"))

        expect(described_class.new(mail.header_fields).autoreply?).to be_truthy
      end

      it "should detect `precedence` header" do
        mail = Mail.new(default_email_headers.merge("precedence" => "auto_reply"))

        expect(described_class.new(mail.header_fields).autoreply?).to be_truthy
      end

      it "should detect `x-precedence` header" do
        mail = Mail.new(default_email_headers.merge("x-precedence" => "auto_reply"))

        expect(described_class.new(mail.header_fields).autoreply?).to be_truthy
      end

      it "should detect `x-precedence` header" do
        mail = Mail.new(default_email_headers.merge("x-precedence" => "bulk"))

        expect(described_class.new(mail.header_fields).autoreply?).to be_truthy
      end

      it "should detect `x-barracuda-spam-status` header" do
        mail = Mail.new(default_email_headers.merge("x-barracuda-spam-status" => "yes"))

        expect(described_class.new(mail.header_fields).autoreply?).to be_truthy
      end

      it "should detect `x-dspam-result` header" do
        mail = Mail.new(default_email_headers.merge("x-dspam-result" => "spam"))

        expect(described_class.new(mail.header_fields).autoreply?).to be_truthy
      end

      it "should detect `x-dspam-result` header" do
        mail = Mail.new(default_email_headers.merge("x-dspam-result" => "blacklisted"))

        expect(described_class.new(mail.header_fields).autoreply?).to be_truthy
      end

      it "should detect `x-mailer` header" do
        mail = Mail.new(default_email_headers.merge("x-mailer" => "mail"))

        expect(described_class.new(mail.header_fields).autoreply?).to be_truthy
      end

      it "should detect `x-mailer` header" do
        mail = Mail.new(default_email_headers.merge("x-mailer" => "Mail"))

        expect(described_class.new(mail.header_fields).autoreply?).to be_truthy
      end

      it "should detect `auto-submitted` header" do
        mail = Mail.new(default_email_headers.merge("auto-submitted" => "auto-replied"))

        expect(described_class.new(mail.header_fields).autoreply?).to be_truthy
      end

      it "should detect `x-autogenerated` header" do
        mail = Mail.new(default_email_headers.merge("x-autogenerated" => "reply"))

        expect(described_class.new(mail.header_fields).autoreply?).to be_truthy
      end

      it "should detect `x-autosubmitted` header" do
        mail = Mail.new(default_email_headers.merge("x-autosubmitted" => "yes"))

        expect(described_class.new(mail.header_fields).autoreply?).to be_truthy
      end
    end
  end
end
