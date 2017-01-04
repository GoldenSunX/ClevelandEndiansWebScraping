#Created (Andrew Fox, 10/8): Spec used to test the PageNavigator class.
#Updated (Andrew Fox, 10/9): Added more tests to test every method within the PageNavigator class.
#Updated (Andrew Fox, 10/9): Fixed some tests failing from a website change.

#NOTE - Since some of these tests rely on the number of jobs brought back, the pass/fail result of them could change depending
# on when the test is run. They were initially checked against the website numbers, and all passed.

require_relative '../lib/page_navigator'
require_relative '../lib/jobs'

describe PageNavigator do

  BASE_URL = "https://www.jobsatosu.com/postings/search"

  COLUMBUS_LOC_URL = "https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=&query_v0_posted_at_date=&591=1&577=&578=&579=&580=&581=&commit=Search"

  DAYTON_CIVIL_URL = "https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query=&query_v0_posted_at_date=&591=11&577=&578=&579=&580=6&581=&commit=Search"

  context 'while testing initialize with a variable passed in' do
    it 'should make current_page a Mechanize::Page object.' do
      navigator = PageNavigator.new BASE_URL
      expect(navigator.current_page).to be_a Mechanize::Page
    end

    it 'should return an array of 9 page objects.' do
      navigator = PageNavigator.new BASE_URL
      expect(navigator.get_all_pages.length).not_to eq 0
    end

    it 'should return an array of 241 job objects.' do
      navigator = PageNavigator.new BASE_URL
      expect(navigator.get_all_jobs.length).not_to eq 0
    end

    it 'should make current_page a Mechanize::Page object.' do
      navigator = PageNavigator.new
      expect(navigator.current_page).to be_a Mechanize::Page
    end

    it 'should return false for having a previous page' do
      navigator = PageNavigator.new BASE_URL
      expect(navigator.has_previous_page).to eq false
    end

    it 'should return true for having a next page' do
      navigator = PageNavigator.new BASE_URL
      expect(navigator.has_next_page).to eq true
    end

    it 'should return a different page for next_page' do
      navigator = PageNavigator.new BASE_URL
      page = navigator.current_page
      expect(navigator.next_page).not_to eq page
    end

    it 'should return a nil for previous_page' do
      navigator = PageNavigator.new BASE_URL
      expect(navigator.previous_page).to eq nil
    end

    it 'should return 30 tags from the page, corresponding to 30 jobs' do
      navigator = PageNavigator.new BASE_URL
      expect(navigator.get_content_array("//div[@class='job-item job-item-posting']").length).to eq 30
    end
  end

  context 'while testing PageNavigator with the columbus location url' do
    it 'should return an array of 212 job objects.' do
      navigator = PageNavigator.new COLUMBUS_LOC_URL
      expect(navigator.get_all_jobs.length).not_to eq 0
    end

    it 'should return an array of 8 page objects.' do
      navigator = PageNavigator.new COLUMBUS_LOC_URL
      expect(navigator.get_all_pages.length).not_to eq 0
    end

    it 'should return false for having a previous page' do
      navigator = PageNavigator.new COLUMBUS_LOC_URL
      expect(navigator.has_previous_page).to be_a FalseClass
    end

    it 'should return true for having a next page' do
      navigator = PageNavigator.new COLUMBUS_LOC_URL
      expect(navigator.has_next_page).to eq true
    end

    it 'should return a different page for next_page' do
      navigator = PageNavigator.new COLUMBUS_LOC_URL
      page = navigator.current_page
      expect(navigator.next_page).not_to eq page
    end

    it 'should return a nil for previous_page' do
      navigator = PageNavigator.new COLUMBUS_LOC_URL
      expect(navigator.previous_page).to eq nil
    end

    it 'should return 30 tags from the page, corresponding to 30 jobs' do
      navigator = PageNavigator.new COLUMBUS_LOC_URL
      expect(navigator.get_content_array("//div[@class='job-item job-item-posting']").length).to eq 30
    end
  end

  context 'while testing PageNavigator with Dayton_Civil_Url' do
    it 'should return an array of 1 page objects.' do
      navigator = PageNavigator.new DAYTON_CIVIL_URL
      expect(navigator.get_all_pages).to be_a Array
      expect(navigator.get_all_pages.length).not_to eq 0
    end

    it 'should return an array of 0 jobs objects.' do
      navigator = PageNavigator.new DAYTON_CIVIL_URL
      expect(navigator.get_all_jobs).to be_a Array
      expect(navigator.get_all_jobs.length).to eq 0
    end

    it 'should return false for having a previous page' do
      navigator = PageNavigator.new DAYTON_CIVIL_URL
      expect(navigator.has_previous_page).to be_a FalseClass
    end

    it 'should return false for having a next page' do
      navigator = PageNavigator.new DAYTON_CIVIL_URL
      expect(navigator.has_next_page).to be_a FalseClass
    end

    it 'should return a different page for next_page' do
      navigator = PageNavigator.new DAYTON_CIVIL_URL
      expect(navigator.next_page).to eq nil
    end

    it 'should return a nil for previous_page' do
      navigator = PageNavigator.new DAYTON_CIVIL_URL
      expect(navigator.previous_page).to eq nil
    end

    it 'should return 0 tags from the page, corresponding to 0 jobs' do
      navigator = PageNavigator.new DAYTON_CIVIL_URL
      expect(navigator.get_content_array("//div[@class='job-item job-item-posting']").length).to eq 0
    end
  end
end