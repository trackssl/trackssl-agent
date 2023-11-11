#!/usr/bin/env ruby

require './environment'

interval = ARGV.shift || '4h'

scheduler = Rufus::Scheduler.new

scheduler.every(interval) do
  Domain.find_each do |domain|
    puts "#{Time.now}: #{domain.name}"
    puts domain.to_json
  end
end

scheduler.join
