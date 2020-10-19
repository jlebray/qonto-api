# frozen_string_literal: true

require ::File.expand_path('../test_helper', __dir__)
ATTACHMENT_RESPONSE = DATA.read

module Qonto
  class AttachmentTest < Test::Unit::TestCase
    setup do
      @attachment_id = 'potato-42'

      stub_request(:get, "#{client.url}/attachments/#{@attachment_id}")
        .to_return(status: 200, body: ATTACHMENT_RESPONSE)
    end

    should 'be retrievable' do
      attachment = Qonto::Attachment.retrieve(@attachment_id)
      assert_requested :get, "#{client.url}/attachments/#{@attachment_id}"
      assert attachment.is_a?(Qonto::Attachment)
    end

    should 'have all the attributes' do
      attachment = Qonto::Attachment.retrieve(@attachment_id)

      assert_equal attachment.created_at, '2019-09-13T08:33:52.695Z'
      assert_equal attachment.file_name, 'a_file_name'
      assert_equal attachment.file_size, '297521'
      assert_equal attachment.file_content_type, 'application/pdf'
      assert_equal attachment.url, 'https://qonto.s3.eu-central-1.amazonaws.com/blabla'
    end

    context '#to_h' do
      should 'serialize all the attributes' do
        attachment = Qonto::Attachment.retrieve(@attachment_id)

        assert_equal(
          attachment.to_h,
          {
            'created_at' => '2019-09-13T08:33:52.695Z',
            'file_name' => 'a_file_name',
            'file_size' => '297521',
            'file_content_type' => 'application/pdf',
            'url' => 'https://qonto.s3.eu-central-1.amazonaws.com/blabla'
          }
        )
      end
    end
  end
end

__END__
{
  "attachment": {
    "created_at": "2019-09-13T08:33:52.695Z",
    "file_name": "a_file_name",
    "file_size": "297521",
    "file_content_type": "application/pdf",
    "url": "https://qonto.s3.eu-central-1.amazonaws.com/blabla"
  }
}
