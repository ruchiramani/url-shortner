require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  describe "POST create" do
   it "creates a rental unit" do
     post "/rental_units", {
       params: {
         data: {
           type: 'rental_units',
           attributes: {
             price_cents: 100000,
             rooms: 2,
             bathrooms: 1
           }
         }
       },
       headers: { 'X-Api-Key' => user.api_key }
     }
     expect(response.status).to eq(201)
     expect(response.headers['Location']).to match(/\/rental_units\/\d$/)
     expect(response.body).to be_jsonapi_response_for('rental_units')
   end
 end
end
