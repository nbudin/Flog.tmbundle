#!/usr/bin/env ruby

begin
  require 'flog'
rescue LoadError
  puts "Install flog!\ngem install flog"
  exit 1
end

COMPLEXITY_WARNING_THRESHOLD = 25

if ARGV.include? '-d'
  require 'flog_cli'
  flog_cli = FlogCLI.new
  flog_cli.flog [ARGV[0], '-d', ENV['TM_FILEPATH']]
  flog_cli.report
else
  begin
    flog = Flog.new(quiet: true, continue: true)
    flog.flog ENV['TM_FILEPATH']

    flog.each_by_score Flog::THRESHOLD do |class_method, score, call_list|
      next unless score >= COMPLEXITY_WARNING_THRESHOLD
      
      location = flog.method_locations[class_method]
      line = location && location.gsub(/.*:/, '')
  
      if line
        message = "Flog score: %0.2f" % [score]
        system ENV['TM_MATE'], "--line=#{line}", "--clear-mark=warning", "--set-mark=warning:#{message}"
      end
    end
  rescue Racc::ParseError
  rescue Exception => e
    puts e.class.name
    puts e.message
  end
end