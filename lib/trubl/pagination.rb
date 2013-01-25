require 'json'

module Trubl
  class Pagination
    attr_accessor :current_page, :order, :per_page, :page, :total_entries

    def from_response(response)
      pagination = pagination_from_response(response)
      @order = pagination["order"]
      @current_page = pagination["current_page"]
      @per_page = pagination["per_page"]
      @page = pagination["per_page"]
      @total_entries = pagination["total_entries"]
      self
    end

    def pagination_from_response(response)
      JSON.parse(response.body)["pagination"]
    end
  end
end