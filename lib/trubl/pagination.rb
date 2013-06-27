module Trubl
  class Pagination
    attr_accessor :current_page, :order, :per_page, :page, :total_entries

    def from_response(response)
      pagination = pagination_from_response(response) || {}
      %w(order current_page per_page page total_entries).each do |attr|
        self.send("#{attr}=", pagination[attr])
      end
      self
    end

    def pagination_from_response(response)
      JSON.parse(response.body)["pagination"]
    end
  end
end