require "readline"
require "rainbow"

herokuApp = ARGV.first

class HeroShell

    def initialize(herokuApp)
        unless herokuApp
            puts "switcher <herokuApp>"
            exit 1
        end
        @app = herokuApp
    end

    def run()
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
