# Install the required gemfiles 
require 'nokogiri'
require 'httparty'
# Call the Scraper class to scrape required information from job portal site
# Takes two inputs - (user query and scrapeoption)
# User query is the search string for the job portal
# scrapeoption - search or save string 
    class Scraper
# Define method to save search content in to a dat file
# parameters - Take user input search query
    def saveJobsinFile(searchJob)
        filename =searchJob +'.dat'
            f=File.open(filename,"w")
            f.puts $jobs
            puts "File : #{searchJob}.dat created successfully"
            f.close
    end
# deine method to initialize the scraper class object
# parameters - take user input search query and scrapeoption
# user input query - to search job portal
    # scrapeoption - search or save string 
    def initialize(searchJob,scrapeoption )
        scraper(searchJob,scrapeoption )
    end
    # Define method to scrape the required data from the job portal url
    # parameters - take user input search query and scrapeoption
    # user input query - to search job portal
    # scrapeoption - search or save string 
    def scraper (searchJob,scrapeoption )
        url = "https://ca.indeed.com/jobs?q=#{searchJob}"
        unparsed_page = HTTParty.get(url)
        parsed_page = Nokogiri::HTML(unparsed_page)
        $jobs = Array.new
        joblistings = parsed_page.css('div.job_seen_beacon') #15 jobs
        page = 0
        total = parsed_page.css('div.searchCountContainer').text.split(' ')[3].to_i
        puts "found total #{total} jobs" 
        jobs_per_page = joblistings.count #15
        last_page = ((total.to_f/ jobs_per_page.to_f).round * 10)
         
    # main search page is used to find the # total , jobs_per_page, last_page, 
    # loop and start over to capture the required columns 
        while page <= last_page
            pagination_url = "https://ca.indeed.com/jobs?q=#{searchJob}&start=#{page}"
            pagination_unparsed_page = HTTParty.get(pagination_url)
            pagination_parsed_page = Nokogiri::HTML(pagination_unparsed_page)
            pagination_joblistings = pagination_parsed_page.css('div.job_seen_beacon') #15 jobs
                pagination_joblistings.each do |joblist|
                    job = {
                        jobTitle: joblist.css('h2.jobTitle').text,
                        companyName: joblist.css('span.companyName').text,
                        companyLocation: joblist.css('div.companyLocation').text
                    }
                $jobs << job
                end # job listing loop 
        page = page + 10 # this site has counter increased by 10
        end  #while loop 

    #Show the list of jobs scraped based on the search
    puts $jobs
    puts "Job(s) count is #{$jobs.count}"

        if scrapeoption =="save"
            saveJobsinFile(searchJob) #pass search as filename to save 
        end
    end
end