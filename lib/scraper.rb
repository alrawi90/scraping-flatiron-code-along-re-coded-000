require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper

    def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
def get_page
  html = open("http://learn-co-curriculum.github.io/site-for-scraping/courses")
  return Nokogiri::HTML(html)
end
def get_courses
  return get_page.css(".post")
end
def make_courses
  course= Course.new
  get_courses.each do |e|
    title=e.css("h2").text
    schedule=e.css(".date").text
    description=e.css("p").text
    course.title=title
    course.schedule=schedule
    course.description=description
  end
  return course
end
end
