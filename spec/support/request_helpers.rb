module Requests
  module Helpers
    def json
      JSON.parse(response.body).deep_symbolize_keys
    end
  end
end
