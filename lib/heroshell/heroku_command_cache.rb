class HeroShell::HerokuCommandsCache
    @@TOPICS_FILE = "#{ENV['HOME']}/.heroku-commands.list"

    def self.sync()
        def self.read_help_topics()
            `heroku help`
                .split("\n")
                .drop_while { |line| !line.start_with? "COMMANDS" }
                .drop(1)
                .select { |l| l[3] != ' '}
                .collect { |l| l.split(' ')[0] }
        end

        def self.read_topic(topic) 
            `heroku help #{topic}`
                .split("\n")
                .drop_while { |line| !line.start_with? "COMMANDS" }
                .drop(1)
                .select { |l| l[3] != ' '}
                .collect { |l| l.split(' ')[0] }
        end

        File.open(@@TOPICS_FILE, "w+") { |f| 
            topics = read_help_topics()
                .flat_map{ |t| read_topic(t) + [t] }
                .join("\n")
            f.write(topics)
        }
    end

    def self.get_commands(forceSync)
        def self.read_topics_file()
            IO.read(@@TOPICS_FILE).split("\n")
        end

        if !File.exist? @@TOPICS_FILE or forceSync
            puts "No commands file found, or sync forced - syncing..."
            sync()
            puts "Syncing done."
            read_topics_file()
        else
            read_topics_file()
        end
    end
end
