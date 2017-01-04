# Created (Sam Yinger, 10/8): Created tests to make sure the submitting of forms were working along with the scraping
# Updated (Sam Yinger, 10/10): Fixed and formatted the tests better

require 'rspec'
require 'scrape'
require 'mechanize'
require 'page_navigator'

describe Scrape do

  before(:each) do
    @agent = Mechanize.new
  end

  # form['578'] = values[0] # University Title
  # form['577'] = values[1] # Working Title
  # form['query'] = values[2] # Keywords
  # form['579'] = values[3] # Job Opening Number
  # posted_time = values[4] # Posted Within
  # job_location = values[5] # Location
  # job_field = values[6] # Job Category
  # work_time = values[7] # Full/Part Time

  context 'with valid input' do

    it '(1) submits a form with certain values and checks against the actual site http' do
      values = ['Dr.', '', 'bank', '', 'Any time period', 'Columbus', 'Instructional/Faculty', 'Any']
      jobs = Scrape.begin_scrape values
      page = @agent.get 'https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=bank&query_v0_posted_at_date=&591=1&577=&578=Dr.&579=&580=2&581=&commit=Search'
      page_navi = PageNavigator.new page.uri.to_s
      correct_jobs = page_navi.get_all_jobs
      expect(jobs).to eq correct_jobs
    end
    it '(2) submits a form with certain values and checks against the actual site http' do
      values = ['', 'Block', '', '1234', 'Last Month', 'Delware', 'Research', 'Full-Time']
      jobs = Scrape.begin_scrape values
      page = @agent.get 'https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=&query_v0_posted_at_date=month&591=8&577=Block&578=&579=1234&580=5&581=4&commit=Search'
      page_navi = PageNavigator.new page.uri.to_s
      correct_jobs = page_navi.get_all_jobs
      expect(jobs).to eq correct_jobs
    end
    it '(3) submits a form with certain values and checks against the actual site http' do
      values = ['', '', '', '', 'Any time period', 'Any', 'Research', 'Temporary']
      jobs = Scrape.begin_scrape values
      page = @agent.get 'https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=&query_v0_posted_at_date=&591=&577=&578=&579=&580=5&581=6&commit=Search'
      page_navi = PageNavigator.new page.uri.to_s
      correct_jobs = page_navi.get_all_jobs
      expect(jobs).to eq correct_jobs
    end
    it '(4) submits a form with certain values and checks against the actual site http' do
      values = ['', 'Master', 'computer', '10', 'Last Week', 'Columbus', 'Information Technology (IT)', 'Part-time']
      jobs = Scrape.begin_scrape values
      page = @agent.get 'https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=computer&query_v0_posted_at_date=week&591=1&577=Master&578=&579=10&580=4&581=5&commit=Search'
      page_navi = PageNavigator.new page.uri.to_s
      correct_jobs = page_navi.get_all_jobs
      expect(jobs).to eq correct_jobs
    end
  end
end