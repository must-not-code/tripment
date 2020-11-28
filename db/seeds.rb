require 'nokogiri'
require 'open-uri'
require 'json'

class String
  def true_strip
    gsub(/\A[[:space:]]*|[[:space:]]*\z/, '')
  end
end

Nokogiri::HTML(URI.open('https://en.wikipedia.org/wiki/Medical_procedure'))
.xpath("//h3[span[@class='mw-headline']]/following-sibling::ul[1]//li/a[not(@class='new')]").each do |link|
  try ||= 1
  response = JSON.load(URI.open("https://en.wikipedia.org/api/rest_v1/page/summary/#{link['href'].sub('/wiki/', '')}"))
  Procedure.create(
    title: response['title'].sub('(medicine)', '')&.true_strip,
    image: response.dig('thumbnail', 'source')&.true_strip,
    description: response['extract']&.true_strip,
  )
rescue
  try += 1
  sleep 5
  try > 3 ? next : retry
end
