# Created (Sam Yinger, 10/8): Contains the Scrape Module
# Updated (Cole Albers, 10/9): Helped clean up code and fixed minor bugs.

require 'mechanize'
require 'open-uri'
require_relative 'page_navigator'

# Public: Module used to insert the user's info in the job's webpage form and retrieve the results
module Scrape
  # Public: Starts the process of scraping the webpage form and filling it with the user information
  #
  # jobs  - The jobs object that contains the users field responses
  #
  # ->Examples
  #
  #   begin_scrape(jobs)
  #   # => {agent.page[]}
  #
  # Returns an array that contains the results from the submitted form
  def self.begin_scrape(values)
    agent = Mechanize.new
    page = agent.get 'https://www.jobsatosu.com/postings/search'
    form = page.form
    Scrape.fill_fields values, form
    page = agent.submit form #submits the form with the user's information
    page_navi = PageNavigator.new page.uri.to_s
    page_navi.get_all_jobs
  end

  # Public: Fills in the fields retrieved from the page
  #
  # jobs  - The object that contains the users entries for each field to be filled
  #
  # Examples
  #
  #   fill_fields(jobs)
  #   # => @agent.page.forms[0]['working_title'] = 'Professor'
  #
  # Updates @agent.page.forms[0]
  def self.fill_fields(values, form)

    #text entry fields

    form['578'] = values[0] # University Title
    form['577'] = values[1] # Working Title
    form['query'] = values[2] # Keywords
    form['579'] = values[3] # Job Opening Number



    #select option fields
    posted_time = values[4] # Posted Within
    job_location = values[5] # Location
    job_field = values[6] # Job Category
    work_time = values[7] # Full/Part Time

    case posted_time
      when 'Last Day'
        form['query_v0_posted_at_date'] = 'day'
      when 'Last Week'
        form['query_v0_posted_at_date'] = 'week'
      when 'Last Month'
        form['query_v0_posted_at_date'] = 'month'
      else
        form['query_v0_posted_at_date'] = ''
    end

    case job_location
      when 'Columbus'
        form['591'] = '1'
      when 'Lima'
        form['591'] = '2'
      when 'Mansfield'
        form['591'] = '3'
      when 'Marion'
        form['591'] = '4'
      when 'Newark'
        form['591'] = '5'
      when 'Wooster'
        form['591'] = '6'
      when 'Delaware'
        form['591'] = '8'
      when 'Springfield'
        form['591'] = '9'
      when 'Piketon'
        form['591'] = '10'
      when 'Dayton'
        form['591'] = '11'
      else
        form['591'] = ''
    end

    case job_field
      when 'Instructional/Faculty'
        form['580'] =  '2'
      when 'Administrative and Professional'
        form['580'] =  '3'
      when 'Information Technology (IT)'
        form['580'] =  '4'
      when 'Research'
        form['580'] =  '5'
      when 'Civil Service'
        form['580'] =  '6'
      else
        form['580'] =  ''
    end

    case work_time
      when 'Part-time'
        form['581'] =  '5'
      when 'Temporary'
        form['581'] =  '6'
      when 'Term'
        form['581'] =  '7'
      when 'Full-Time'
        form['581'] =  '4'
      else
        form['581'] = ''
    end
  end
end

