require 'rails_helper'
require 'webmock/rspec'

RSpec.describe Rawg::Request do
  describe ".call" do
    let(:base_url) { "https://api.rawg.io/api" }
    let(:token) { ENV['RAWG_API_TOKEN'] }
    let(:endpoint) { '/games' }
    let(:url) { "#{base_url}#{endpoint}?key=#{token}" }

    context 'when the request is successful' do
      before do
        stub_request(:get, url)
          .to_return(status: 200, body: { results: [{ name: 'Game1' }, { name: 'Game2' }] }.to_json, headers: { 'Content-Type' => 'application/json' })
      end

      it 'returns the correct response' do
        response = Rawg::Request.call(:get, endpoint)
        expect(response[:code]).to eq(200)
        expect(response[:status]).to eq('Success')
        expect(response[:data]).to eq('results' => [{ 'name' => 'Game1' }, { 'name' => 'Game2' }])
      end
    end

    context 'when the request is invalid' do
      before do
        stub_request(:get, url)
          .to_return(status: 404, body: { message: '404 Not Found' }.to_json, headers: { 'Content-Type' => 'application/json' })
    end

      it 'returns the correct error response' do
        response = Rawg::Request.call(:get, endpoint)
        expect(response[:code]).to eq(404)
        expect(response[:status]).to eq('404 Not Found')
        expect(response[:data]).to eq('Invalid request!')
      end
    end

    context 'when the token is wrong or invalid' do
      before do
        stub_request(:get, url)
          .to_return(status: 401, body: { message: 'Unauthorized request. Please try again!' }.to_json, headers: { 'Content-Type' => 'application/json' })
    end

      it 'returns the correct error response' do
        response = Rawg::Request.call(:get, endpoint)
        expect(response[:code]).to eq(401)
        expect(response[:status]).to eq('401 Unauthorized')
        expect(response[:data]).to eq('Unauthorized request. Please try again!')
      end
    end

    context 'when the site is not working' do
      it 'handles other errors' do
        other_error_codes = [*501..504]
        other_error_codes.each do |error|
            stub_request(:get, url)
              .to_return(status: error, body: { message: 'Service unavailable. Please try again!' }.to_json, headers: { 'Content-Type' => 'application/json' })

              response = Rawg::Request.call(:get, endpoint)
              expect(response[:code]).to eq(error)
              case error
                when 501
                  expect(response[:status]).to eq('501 Not Implemented')
                when 502
                  expect(response[:status]).to eq('502 Bad Gateway')
                when 503
                  expect(response[:status]).to eq('503 Service Unavailable')
                when 504
                  expect(response[:status]).to eq('504 Gateway Timeout')
              end
              expect(response[:data]).to eq('Service unavailable. Please try again!')
              end
            end
          end
    


  end
end




