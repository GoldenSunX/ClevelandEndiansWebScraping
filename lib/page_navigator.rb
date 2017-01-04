# Created (Andrew Fox, 10/8): PageNavigator class for using mechanize and nokogiri with a mechanize page to get all jobs
# Updated (Sam Yinger, 10/9): Fixed documentation to tomdocs format
# Updated (Andrew Fox, 10/9): Added get_page_jobs and refactored jobs to get_all_jobs
# Updated (Andrew Fox, 10/10): Added proper requires for dependencies

# Public: Class used to create and display PageNavigator objects.
#
# Examples
#
#   PageNavigator.new
#   # => (PageNavigator object)
class PageNavigator
  require 'mechanize'
  require 'nokogiri'
  require_relative '../lib/jobs'

  # Created (Andrew Fox, 10/8).
  # Internal: Constant containing the default search url.
  BASE_URL = 'https://www.jobsatosu.com/postings/search'

  # Created (Andrew Fox, 10/8).
  # Public: Gets/Sets the mechanize page of current_page
  attr_accessor :current_page

  # Created (Andrew Fox, 10/8).
  # Public: Initialize a PageNavigator object.
  #
  # url - the uri for the page
  #
  # Example:
  #
  #   PageNavigator.new
  #   # => (PageNavigator Object)
  def initialize(url = BASE_URL)
    @agent = Mechanize.new
    @current_page = @agent.get url
  end

  # Created (Andrew Fox, 10/8)
  # Public: Creates an array of the content of all tags matching xpath_query with current_page.
  #
  # xpath_query - html tag
  #
  # Examples
  #
  #   get_content_array('tr')
  #   # => [<td>...<td>, <td>...<td>, ...]
  #
  # Returns the array of content strings.
  def get_content_array(xpath_query)
    scraped_array = Array.new
    pos = 0
    @current_page.search(xpath_query).each do |var|
      scraped_array[pos] = var.content.strip
      pos += 1
    end
    scraped_array
  end

  # Created (Andrew Fox, 10/8)
  # Public: Changes current_page to be the next link from the website.
  #
  # Examples
  #
  #   next_page
  #   # => (html of page(n+1))
  #
  # Returns the new current_page if there is one or nil if current_page hasnt changed.
  def next_page
    @current_page = @agent.page.links.find { |l| l.text == "Next →" }.click
  rescue
    nil
  end

  # Created (Andrew Fox, 10/8)
  # Public: Checks if the website has a next page.
  #
  # Examples
  #
  #   has_next_page
  #   # => true
  #
  # Returns true if there is a next page or false if there is not.
  def has_next_page
    @agent.page.links.find { |l| l.text == "Next →" } == nil ? false : true
  end

  # Created (Andrew Fox, 10/8)
  # Public: Changes current_page to be the previous link from the website.
  #
  # Examples
  #
  #   previous_page
  #   # => (html of page(n-1))
  #
  # Returns the new current_page if there is one or nil if current_page hasnt changed.
  def previous_page
    @current_page = @agent.page.links.find { |l| l.text == "← Previous" }.click
  rescue
    nil
  end

  # Created (Andrew Fox, 10/8)
  # Public: Checks if the website has a previous page.
  #
  # Examples
  #
  #   has_previous_page
  #   # => true
  #
  # Returns true if there is a previous page or false if there is not.
  def has_previous_page
    @agent.page.links.find { |l| l.text == "← Previous" } == nil ? false : true
  end

  # Created (Andrew Fox, 10/8)
  # Private: Gets an array of all pages starting from current_page.
  #
  # Examples
  #
  #   previous_page
  #   # => [(html of page 1), (html of page 2), (html of page 3), ...]
  #
  # Returns the array of mechanize page objects.
  def get_all_pages
    list_of_pages = Array.new
    list_of_pages[0] = @current_page
    pos = 1
    while @agent.page.links.find { |l| l.text == "Next →" } == nil ? false : true
      list_of_pages[pos] = @agent.page.links.find { |l| l.text == "Next →" }.click
      pos += 1
    end
    list_of_pages
  end

  # Created (Andrew Fox, 10/9)
  # Public: Gets an array of all jobs from current_page to the last "Next" link on the website.
  #
  # Yields
  #
  #   Allows the passing of block of code that contains 1 variable that can be used to iterate over the job objects
  #
  # Examples
  #
  #   jobs {block}
  #   # => [job1, job2, job3, ...]
  #
  # Returns the array of jobs objects.
  def get_page_jobs
    count = 0
    jobs = Array.new

    @current_page.search("//div[@class='job-item job-item-posting']").each do |job|
      info_array = Array.new
      pos = 0
      tr_tag_items = job.search(".//table/tr")
      tr_tag_items[0].search(".//td").each do |info_item|
        info_array[pos] = info_item.content.strip
        pos += 1
      end

      info_array[pos] = tr_tag_items[1].search(".//span[@class='job-description']").first.content.strip
      job = Jobs.new *info_array
      jobs[count] = job
      count += 1
      yield job if block_given?
    end
    jobs
  end

  # Created (Andrew Fox, 10/8)
  # Public: Gets an array of all jobs from current_page to the last "Next" link on the website.
  #
  # Yields
  #
  #   Allows the passing of block of code that contains 1 variable that can be used to iterate over the job objects
  #
  # Examples
  #
  #   jobs {block}
  #   # => [job1, job2, job3, ...]
  #
  # Returns the array of jobs objects.
  def get_all_jobs
    count = 0
    jobs = Array.new

    self.get_all_pages.each do |page|
      page.search("//div[@class='job-item job-item-posting']").each do |job|
        info_array = Array.new
        pos = 0
        tr_tag_items = job.search(".//table/tr")
        tr_tag_items[0].search(".//td").each do |info_item|
          info_array[pos] = info_item.content.strip
          pos += 1
        end

        info_array[pos] = tr_tag_items[1].search(".//span[@class='job-description']").first.content.strip
        job = Jobs.new *info_array
        jobs[count] = job
        count += 1
        yield job if block_given?
      end
    end
    jobs
  end
end
