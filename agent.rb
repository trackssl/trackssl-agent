#!/usr/bin/env ruby

require './environment'

interval = ARGV.shift || '4h'

scheduler = Rufus::Scheduler.new
agent = Agent.new

agent.call

scheduler.every(interval) do
  agent.call
end

scheduler.join
