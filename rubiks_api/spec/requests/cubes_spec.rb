require 'rails_helper'

RSpec.describe "Cubes API", type: :request do
    let!(:cube) {CubesService.create_cube}

    describe "GET /cubes" do
        it "returns all cubes" do
            get "/cubes"

            expect(response).to have_http_status(:ok)
            json = JSON.parse(response.body)
            expect(json).to be_an(Array)
            expect(json.size).to be >= 1
            expect(json.first["state"]["front"]).to eq([["R","R","R"], ["R","R","R"], ["R","R","R"]])
        end
    end

    describe "GET /cubes/:id" do
        it "returns cube by id" do
            get "/cubes/#{cube.id}"

            expect(response).to have_http_status(:ok)
            json = JSON.parse(response.body)
        
            expect(json["front"]).to eq([["R","R","R"], ["R","R","R"], ["R","R","R"]])
            expect(json["top"]).to eq([["W","W","W"], ["W","W","W"], ["W","W","W"]])
        end
    end


end