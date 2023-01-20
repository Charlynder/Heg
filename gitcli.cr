## @FileName : Gcli 

## this program to make git a little but easier
require "option_parser"

struct Flag_methods

    def init
        system("git init")
    end

    ## add directories functions
    def add
        
        ## if the use w
        system("git add .")

        system("git add .\/#{dir}")
    end

    def commit(message : String)
        system("git commit -m \"#{message}\"")
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

    parser.on "-p", "--push", "Push staged code to git repository" do
        FL.push()
        exit
    end

    parser.on "-P", "--force-push", "Force push code to a git repository" do
        FL.force_push()
        exit
    end

    parser.on "-pl", "--pull", "Pull code from remote git repository" do
        FL.pull()
        exit
    end

    parser.on "init", "", "Initalize git in repository" do
        FL.init()
        exit
    end

end