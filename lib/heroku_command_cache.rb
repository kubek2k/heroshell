class HerokuCommandsCache
    @@TOPICS_FILE = "#{ENV['HOME']}/.heroku-commands.list"

    def self.sync()
        def self.read_help_topics()
            lines = `heroku help`.split("\n").drop(4)
            lines
            .select { |l| l[1] != ' ' }
            .collect { |l| l.strip().split(' ')[0] }
        end

        def self.read_topic(topic) 
            lines = `heroku help #{topic}`.split("\n")
            lines
            .drop_while { |line| !line.start_with? "heroku #{topic} commands" }
            .drop(1)
            .select { |l| l[1] != ' ' }
            .collect { |l| l.strip().split(' ')[0] }
        end

        File.open(@@TOPICS_FILE, "w+") { |f| 
            f.write(read_help_topics()
                    .flat_map{ |t| read_topic(t) }
                    .join("\n"))
        }
    end

    def self.get_topics()
        def self.read_topics_file()
            IO.read(@@TOPICS_FILE).split("\n")
        end

        if File.exist? @@TOPICS_FILE
            read_topics_file()
        else
            puts "No commands file found - syncing.."
            sync()
            puts "Syncing done."
            read_topics_file()
        end
    end
end