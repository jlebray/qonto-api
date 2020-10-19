# frozen_string_literal: true

require ::File.expand_path('../test_helper', __dir__)
ERROR_RESPONSE = DATA.read

module Qonto
  class ErrorTest < Test::Unit::TestCase
    setup do
      @attachment_id = 'potato-42'

      stub_request(:get, "#{client.url}/attachments/#{@attachment_id}")
        .to_return(status: 400, body: ERROR_RESPONSE)
    end

    should 'raise an APIError' do
      error = Qonto::APIError.new(
        'That was a bad input',
        status: 400,
        body: ERROR_RESPONSE,
        headers: {}
      )

      assert_raise(error) do
        Qonto::Attachment.retrieve(@attachment_id)
      end
    end
  end
end

__END__
{
  "error_model": {
    "code": 400,
    "message": "That was a bad input"
  }
}
