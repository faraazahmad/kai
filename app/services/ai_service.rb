require 'net/http'
require 'uri'

class Services::AiService
  def get_pdf_markdown(url)
    uri = URI('http://localhost:8000/submission/pdf')
    data = { url: url }.to_json

    # Set headers
    headers = { 'Content-Type' => 'application/json' }

    # Send the request
    response = Net::HTTP.post(uri, data, headers)

    # Check if the request was successful
    if response.is_a?(Net::HTTPSuccess)
      puts "Request successful: #{response.code}"
    else
      puts "Request failed: #{response.code}"
    end
    puts "Response body: #{response.body}"

    response.body
  end

  def get_video_transcript(url)
    uri = URI('http://localhost:8000/submission/youtube')
    data = { url: url }.to_json

    # Set headers
    headers = { 'Content-Type' => 'application/json' }

    # Send the request
    response = Net::HTTP.post(uri, data, headers)

    # Check if the request was successful
    if response.is_a?(Net::HTTPSuccess)
      puts "Request successful: #{response.code}"
    else
      puts "Request failed: #{response.code}"
    end
    puts "Response body: #{response.body}"

    response.body
  end
end
