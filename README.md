# Project 3
### Web Scraping
Before running the Web Scraping project, please install all of the
needed Gems by typing 'bundler install' in the command line.

Web Scraping can be executed by running the "gui.rb" file (located in lib). 

To scrape https://www.jobsatosu.com/postings/search for jobs:
 1) Navigate to the Search page by clicking the "Begin Web Scraping" button.
 2) If the GUI window looks funny when you click the button, please adjust 
 your window and the GUI should fix itself. (Some users experience 
 minor visual hiccups when using Shoes)
 3) Once on the Search page, fill in as much information as you like.
 4) Once you have filled in all desired fields, click the "Search Listings"
 button.
 5) After a few seconds, your jobs (5 to start) will begin to appear in the area below
 the buttons. Shoes can be slow, so it might take 5-10 seconds
 before it will begin to display the job information.
 6) If you would like more jobs to be displayed, simply click the
 "Show More" button, and 5 more jobs (if available) will appear. Feel free to click
 the button as many times as you like to get the jobs you desire, if they
 are available.
 7) To exit the program, simply click the X button at the top left side of
 the GUI.
 
To test our code, type 'rspec spec spec' in the command line 
while in the main directory (Cleveland...).

### Roles
* Overall Project Manager: Adam Prater
* Coding Manager: Cole Albers
* Testing Manager: David Sinchok
* Documentation: Sam Yinger

### Contributions

Cole Albers:
* Created the README.md file.
* Helped implement the two GUI buttons.
* Created the Jobs class.
* Created the jobs_spec tests.

Sam Yinger:
* Documented the page_navigator file.
* Created the Scrape module.
* Helped document the gui file.

David Sinchok:
* Created the two pages of the GUI, including the input fields.

Adam Prater:
* Implemented the job display section of the GUI.
* Helped implement the two GUI buttons.

Andrew Fox:
* Added multi-threading and locks to the buttons in the GUI.
* Created the PageNavigator class.
* Created the page_navigator_spec tests.

"Created" implies that the individual who created the 
class/tests/methods implemented the bulk of the code for the file.