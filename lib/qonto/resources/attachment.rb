# frozen_string_literal: true

module Qonto
  class Attachment < Resource
    extend Qonto::APIOperations::Retrieve

    OBJECT_NAME = 'attachment'
    ATTRIBUTES = %w[
      created_at
      file_name
      file_size
      file_content_type
      url
    ].freeze

    attr_accessor(*ATTRIBUTES)
  end
end
