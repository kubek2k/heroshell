require "readline"
require "rainbow"

herokuApp = ARGV.first

unless herokuApp 
    puts "switcher <herokuApp>"
    exit 1
end

while buf = Readline.readline("(#{Rainbow(herokuApp).red})> ", false).strip()
    if buf.empty?
       next 
    end
    if buf.start_with?("switch ")
       switchTo = buf.split(" ")[1] 
       if switchTo
           herokuApp = switchTo
           Readline::HISTORY.push(buf)
       else
           $stderr.puts "use: \"switch <herokuApp>\" to switch to other app"
       end
    else
        command = "heroku #{buf} -a #{herokuApp}"
        res = system(command)
        if res 
            Readline::HISTORY.push(buf)
        else
            $stderr.puts "Command \"#{command}\" returned non-zero status."
        end
    end
end
