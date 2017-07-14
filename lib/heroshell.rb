require "readline"
require "rainbow"


class HeroShell
    def initialize(herokuApp)
        unless herokuApp
            puts "switcher <herokuApp>"
            exit 1
        end
        @app = herokuApp

    end

    def init_completion()
        autocompleted_commands = HerokuCommandsCache.get_commands()
        Readline.completion_append_character = " "
        Readline.completion_proc = proc { |s| 
            autocompleted_commands.grep(/^#{Regexp.escape(s)}/)
        }
    end

    def run()
        init_completion()
        while buf = Readline.readline("(#{Rainbow(@app).red})> ", false)
            buf = buf.strip()
            if buf.empty?
                next 
            end
            if buf.start_with?("switch ")
                switchTo = buf.split(" ")[1] 
                if switchTo
                    @app = switchTo
                    Readline::HISTORY.push(buf)
                else
                    $stderr.puts "use: \"switch <herokuApp>\" to switch to other app"
                end
            else
                command = "heroku #{buf} -a #{@app}"
                res = system(command)
                if res 
                    Readline::HISTORY.push(buf)
                else
                    $stderr.puts "Command \"#{command}\" returned non-zero status."
                end
            end
        end
    end
end

require "heroshell/heroku_command_cache"
