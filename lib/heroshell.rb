require "readline"
require "rainbow"

class HeroShell
    def initialize(herokuApp, forceCommandsSync)
        @forceCommandSync = forceCommandsSync
        @app = herokuApp
    end

    def init_completion()
        autocompleted_commands = HerokuCommandsCache.get_commands(@forceCommandSync)
        Readline.completion_append_character = " "
        Readline.completer_word_break_characters = ""
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
                begin
                    command, arguments = buf.split(/\s+/, 2)
                    res = system("heroku #{command} -a #{@app} #{arguments}")
                    if res 
                        Readline::HISTORY.push(buf)
                    else
                        $stderr.puts "Command \"#{command}\" returned non-zero status."
                    end
                rescue Interrupt => e
                    $stderr.puts "Command was interrupted, continueing"
                end
            end
        end
        puts ''
    end
end

require "heroshell/heroku_command_cache"
