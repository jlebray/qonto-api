# frozen_string_literal: true

module Qonto
  class ListObject
    include Enumerable
    include Qonto::APIOperations::Request
    include Qonto::APIOperations::List

    attr_accessor :data, :meta, :url, :params

    def initialize(data, meta, url, params = {})
      self.data = data
      self.meta = meta
      self.url = url
      self.params = params
    end

    def each(&block)
      data.each(&block)
    end

    def auto_paging(&block)
      return enum_for(:auto_paging) unless block_given?

      page = self
      loop do
        break if page.empty?

        page.each(&block)
        page = page.next_page
      end
    end
    alias auto_paging_each auto_paging

    def next_page
      return if current_page >= total_pages

      list(params.merge(current_page: current_page + 1))
    end

    def empty?
      data.empty?
    end

    def current_page
      meta['current_page']
    end

    def total_pages
      meta['total_pages']
    end
  end
end
