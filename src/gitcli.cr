## @FileName : Gcli 

## this program to make git a little but easier
require "option_parser"

struct Flag_methods
    ## initicalize git repo
    def init
        system("git init")
    end
    
    ## add git user info
    def user
        puts "Do you want to add user config info to git?"
        print "[Y] Yes [N] No [q] Quit : "
        user_input = gets

        case user_input
        when "y", "Y"
            print "User name : "
            user_name = gets
            print "User email : "
            user_email = gets

            system("git cofig --global user.name \"#{user_name}\"")
            system("git cofig --global user.email \"#{user_email}\"")
        when "q", "Q"
            exit
        else
            exit
        end
    end

    ## add directories functions
    def add
        ## get user input
        puts "Do you want to add a specific file directory? "
        print "[Y] Specify file [N] Add the whole directory [q] Don't add files : "
        user_input = gets
        
        ## if the user wants add the whole directory
        case user_input
        when "y", "Y"
            print "File name : "
            path = gets

            system("git add .\/#{path}")
        when "n", "N"
            system("git add .")
        when "q", "Q"
            exit
        else
            system("git add .")
        end    
    end

    ## commmits
    def commit(message : String)
        system("git commit -m \"#{message}\"")
    end
    
    def amend(message : String)
        system("git commit --amend -m \"#{message}\"")
        
    end

    ## push/pull
    def push
        system("git push")
    end

    def pull
        system("git pull")
    end

    def force_push()
        system("git push --force")
    end
end

## Create Flag_methods object
FL = Flag_methods.new

## Define variables for the flags
git_message : String
message_amend : String

option_parser = OptionParser.parse do |parser|

    parser.banner = "GitC v.0.1 alpha \n"

    parser.on "-v", "--version", "Show verson" do
    puts "GitC version 0.1 alpha \n\nUsing Crystal Lang version 1.7.0"
        exit
    end

    parser.on "-h", "--help", "Show Help" do 
        puts parser
        exit
    end

    parser.on  "-a", "--add", "Stage code to be add to git repository" do
        FL.add()
        exit
    end

    parser.on "-c message", "--commit=message", "Commit code with message" do |message|
        git_message = message
        FL.commit(git_message) 
        exit
    end

    parser.on "-A message", "--amend=message", "Amends git commit" do |message|
        message_amend = message
        FL.amend(message_amend)
        exit
    end

    parser.on "-p", "--push", "Push staged code to git repository" do
        FL.push()
        exit
    end

    parser.on "-f", "--force-push", "Force push code to a git repository" do
        FL.force_push()
        exit
    end

    parser.on "-pl", "--pull", "Pull code from remote git repository" do
        FL.pull()
        exit
    end

    parser.on "", "--init", "Initalize git in repository" do
        FL.init()
        exit
    end

    parser.on "", "--userconfig", "Add user config info \ni.e. \"Harold Mason\", \"horald.m@companysite.com\" " do
        FL.user()
        exit
    end

end