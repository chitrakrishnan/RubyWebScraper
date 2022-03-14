require_relative 'scraper_core'

#Create an interactive Menu program 
# Option 1 To just list the scrape 
# Option 2 To List and save it to a file 
# Option 3 exit the program

class Mainmenu
#Call the main_menu method to show the interactive menu to user
    def initialize 
        main_menu
    end
private
# main_menu method give user 3 options to choose from
# 1-List the search
# 2-List and save the search
# 3-Exit the program

    def main_menu
    puts "Search indeed.ca"
    puts "1.List the Search"
    puts "2.List and save the search"
    puts "3.exit"
    print "Select option number 1, 2 or 3: "
   
    userOption =$stdin.gets.strip 
    while (userOption != "1" && userOption != "2" && userOption !="3")
            puts "Please enter a valid Option.Type 1 OR 2 OR 3 "
            userOption =$stdin.gets.strip
            if (userOption == "1" || userOption == "2" || userOption =="3")
                break
            end 
    end
    case userOption
        when "1"
            puts "List the search "
            @scrapeoption ="search"
            puts "enter Search query : "
            query =$stdin.gets.strip 
            while query =="" 
                    puts "Please enter a valid search "
                    query =$stdin.gets.strip
                    if query !=""
                        break
                    end 
            end  
            puts "Please wait while the search on Indeed.ca is done"
            # Initiate an object "Scraper" from scraper_core.rb
            Scraper.new(query,@scrapeoption ) 
            main_menu
        when "2"
            puts "List and save the search"
            @scrapeoption ="save"
            puts "enter Search query : "
            puts "> "
            query =$stdin.gets.strip 
            while query =="" 
                    puts "Please enter a valid search "
                    query =$stdin.gets.strip
                    if query !=""
                        break
                    end  
            end 
        puts "Please wait while the search on Indeed.ca is done"
        # Initiate an object "Scraper" from scraper_core.rb
        Scraper.new(query,@scrapeoption)
         
        main_menu
        when "3"
            puts "Bye bye"
            exit
        else 
            puts "Invalid entry"
            main_menu
        end
    end
end