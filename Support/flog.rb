#!/usr/bin/env ruby

begin
  require 'flog'
rescue LoadError
  puts "Install flog!\ngem install flog"
  exit 1
end

COMPLEXITY_THRESHOLDS = {
  note: 25,
  warning: 50
}

if ARGV.include? '-d'
  require 'flog_cli'
  flog_cli = FlogCLI.new
  flog_cli.flog [ARGV[0], '-d', ENV['TM_FILEPATH']]
  flog_cli.report
else
  begin
    flog = Flog.new(quiet: true, continue: true, all: true)
    flog.flog ENV['TM_FILEPATH']
    
    COMPLEXITY_THRESHOLDS.keys.each do |level|
      system ENV['TM_MATE'], "--clear-mark=#{level}"
    end

    flog.each_by_score do |class_method, score, call_list|
      level, _ = COMPLEXITY_THRESHOLDS.select { |_, threshold| threshold <= score }.max_by { |_, threshold| threshold }
      next unless level
      
      location = flog.method_locations[class_method]
      line = location && location.gsub(/.*:/, '')

      if line
        message = "#{class_method} complexity: %0.2f" % [score]
        system ENV['TM_MATE'], "--line=#{line}", "--set-mark=#{level}:#{message}"
      end
    end
  rescue Racc::ParseError
  rescue Exception => e
    puts "Error while running Flog:\n#{e.class.name} - #{e.message}"
  end
end