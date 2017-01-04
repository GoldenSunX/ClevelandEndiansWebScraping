# Created (David Sinchok, 10/9): Contains the GUI for the user to interact with.
# Updated (Adam Prater, 10/9):  Implemented the GUI to display jobs.
# Updated (Andrew Fox, 10/9): Added multithreading to the buttons and locks to keep them from being pressed when inappropriate.
# Updated (Cole Albers, 10/9): Helped implement the Search Listing and Show More buttons.
# Updated (David Sinchok, 10/9):  Finalized GUI, doubled the app width and fixed the stacks and flows affected.
# Updated (Sam Yinger, 10/10):  Adjusted the documentation to tomdocs format.
# Updated (Cole Albers, 10/10): Fixed logic error in Show More button.

require 'green_shoes'
require_relative 'scrape'
require_relative 'jobs'

# Public: Class that allows the user to interact with a GUI
class Gui < Shoes #Makes Gui a subclass of shoes allowing for multiple pages in the GUI
  url '/', :start
  url '/search', :search

  #Created (Andrew Fox, 10/9): Method used for resetting data table.
  # Public: Gets an array of all jobs from current_page to the last "Next" link on the website.
  #
  # Examples
  #
  #   clear_job_data
  #   # => true
  #
  # Returns true if successful, false otherwise.
  def clear_job_data
    @job_flows.each_index do |index|
      @job_flows[index].clear
      case index
      when 0
        @job_flows[index].append do
          background 'aquamarine'
          banner 'Title', align: 'center', size: 20
        end
      when 1
        @job_flows[index].append do
          background 'lightskyblue'
          banner 'Department', align: 'center', size: 20
        end
      when 2
        @job_flows[index].append do
          background 'plum'
          banner 'Application Deadline', align: 'center', size: 20
        end
      when 3
        @job_flows[index].append do
          background 'pink'
          banner 'Job Opening Number', align: 'center', size: 20
        end
      when 4
        @job_flows[index].append do
          background 'papayawhip'
          banner 'Target Salary', align: 'center', size: 20
        end
      else
        @job_flows[index].append do
          background 'silver'
          banner 'Description', align: 'center', size: 20
        end
      end
    end
    true
  rescue
    false
  end

  #First page of the application
  #Displays the brutus picture and allows the user to click to enter the application
  def start
    flow :width => 1000, :margin => 10 do
      stack :width => '100%' do
        banner 'Careers at Ohio State',:stroke => darkred
      end

      stack width: 500, margin_left: 200 do
        b = button 'Begin Web Scraping', :width => '30%', :displace_left => '100' do
          visit '/search'
        end

        image 'brutus.jpg', height: 400, width: 400
      end
    end
  end

  #Second page of the application
  #Displays the fields where the user can enter and select the job information he wants to scrape for
  def search
    #Top row of the page
    flow width: 1.0, margin:2 do
      #left column
      stack width: 0.10, margin: 5 do
        para "Keywords:", size: 'large'
        para 'Posted Within:', size: 'large'
      end

      #right column
      stack width: 0.15 do
        @keywords = edit_line margin_bottom:5
        @posted_within = list_box :items => %w(Any\ time\ period Last\ Day Last\ Week Last\ Month), width: 150, choose: 'Any time period'
      end
    end

    #Middle row of the page
    flow width: 1.0 do
      background whitesmoke

      #Left most column of middle row
      stack margin: 5, width: 0.10 do

        para "Location:", size: 'large'
        para "University Title:", size: 'large'
        para "Job Category:", size: 'large'

      end

      #middle-left column of middle row
      stack margin_left: 5, width: 0.2 do
        @location = list_box :items => %w(Any Columbus Lima Mansfield Marion Newark Wooster Delaware Springfield Piketon Dayton),:width => '110px', choose: 'Any', margin_bottom:6, margin_top: 2
        @university_title = edit_line width: 170, margin_bottom:6
        @job_category = list_box :items => %w(Any Instructional/Faculty Administrative\ and\ Professional Information\ Technology\ \(IT\) Research Civil\ Service), choose: 'Any'
      end

      #middle-right column of middle row
      stack width: 0.12, margin: 5 do
        para "Working Title:", size: 'large'
        para "Job Opening Number:", size: 'large'
        para "Full/Part Time:", size: 'large'
      end

      #right most column of middle row
      flow :width => 0.2 do
        stack do
          @working_title = edit_line margin_bottom:6, margin_top: 2
          @job_opening_number = edit_line margin_bottom:6
          @full_part_time = list_box :items => %w(Any Full\ Time Part\ Time Temporary Term), choose: 'Any'
        end
      end
    end

    #Stack containing the search and show more buttons.
    stack width: 1.0 do
      #Keeps the user from spamming the buttons and breaking the application
      buttons_enabled = true
      enable = false
      @position = 0

      #Perform web scrape using the form information entered by the user. Show first 5 results.
      button 'Search Listings', margin: 5 do
        if buttons_enabled
          buttons_enabled = false
          @position = 0
          Thread.new do
            clear_job_data
            @jobs = Scrape.begin_scrape([@university_title.text,@working_title.text,@keywords.text,@job_opening_number.text,@posted_within.text,@location.text,@job_category.text,@full_part_time.text])
            enable = true
            @counter = 0

            while @counter < 5 && @position < @jobs.size

              @f1.append do
                edit_box @jobs[@counter].university_title.to_s, width: 1.0, height: 200, align: 'center'
              end

              @f2.append do
                edit_box @jobs[@counter].department.to_s, width: 1.0, height: 200, align: 'center'
              end

              @f3.append do
                edit_box @jobs[@counter].application_deadline.to_s, width: 1.0, height: 200, align: 'center'
              end

              @f4.append do
                edit_box @jobs[@counter].requisition_number.to_s, width: 1.0, height: 200, align: 'center'
              end

              @f5.append do
                edit_box @jobs[@counter].target_salary.to_s, width: 1.0, height: 200, align: 'center'
              end

              @f6.append do
                edit_box @jobs[@counter].summary_of_duties.to_s, width: 1.0, height: 200, align: 'center'
              end

              @counter += 1
              @position += 1
            end
            buttons_enabled = true
          end
        end
      end

      #Show the next 5 results, using a different thread to keep ui from locking up.
      button 'Show More', margin: 5 do
        if buttons_enabled
          buttons_enabled = false
          Thread.new do
            if enable
              @counter = 0
              @total = @position + @counter
              while @counter < 5 && @total < @jobs.size
                @f1.append do
                  @t1 = edit_box @jobs[@position + @counter].university_title.to_s, width: 1.0, height: 200, align: 'center'
                end

                @f2.append do
                  @t2 = edit_box @jobs[@position + @counter].department.to_s, width: 1.0, height: 200, align: 'center'
                end

                @f3.append do
                  @t3 = edit_box @jobs[@position + @counter].application_deadline.to_s, width: 1.0, height: 200, align: 'center'
                end

                @f4.append do
                  @t4 = edit_box @jobs[@position + @counter].requisition_number.to_s, width: 1.0, height: 200, align: 'center'
                end

                @f5.append do
                  @t5 = edit_box @jobs[@position + @counter].target_salary.to_s, width: 1.0, height: 200, align: 'center'
                end

                @f6.append do
                  @t6 = edit_box @jobs[@position + @counter].summary_of_duties.to_s, width: 1.0, height: 200, align: 'center'
                end
                @counter += 1
                @total += 1
              end
              @position += 5
            end
            buttons_enabled = true
          end
        end
      end
    end

      flow width: 2000 do
        @f1 = flow width: 0.15 do
          background 'aquamarine'
          banner 'Title', align: 'center', size: 20
        end

        @f2 = flow width: 0.15 do
          background 'lightskyblue'
          banner 'Department', align: 'center', size: 20
        end

        @f3 = flow width: 0.15 do
          background 'plum'
          banner 'Application Deadline', align: 'center', size: 20
        end

        @f4 = flow width: 0.15 do
          background 'pink'
          banner 'Job Opening Number', align: 'center', size: 20
        end

        @f5 = flow width: 0.15 do
          background 'papayawhip'
          banner 'Target Salary', align: 'center', size: 20
        end

        @f6 = flow width: 0.15 do
          background 'silver'
          banner 'Description', align: 'center', size: 20
        end
        @job_flows = Array.new [@f1, @f2, @f3, @f4, @f5, @f6]
      end

    rect 1,1,height:170, width: 1998, fill: nofill, stroke: darkgray
    rect 1,1,height:70, width: 1998, fill: nofill, stroke: darkgray
  end
  Shoes.app :width => 2000, :height => 600, :title => "Job Searching"
end
