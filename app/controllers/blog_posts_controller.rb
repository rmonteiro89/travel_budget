require 'rest-client'

class BlogPostsController < ApplicationController
  def index
    @posts = posts
  end

  private

  def posts
    response = RestClient.get 'https://vanessajennylee.wordpress.com'
    document = Nokogiri::HTML(response.body)

    articles = document.css('article')
    array = []
    articles.each do |art|
      hash_a = {
        url: art.css('a')[0]['href'],
        img: art.css('img')[0]['src'],
        title: art.css('h1').text
      }
      array << hash_a
    end

    array
  end
end
