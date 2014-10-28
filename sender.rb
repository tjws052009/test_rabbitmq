# -*- coding:utf-8 -*-
#
require 'bundler/setup'
require 'bunny'

conn = Bunny.new
conn.start

ch = conn.create_channel
x  = ch.fanout("logs")


100_000.times do |a|
  msg = "#{Time.now.to_i}"
  x.publish(msg)
  puts " [x] Sent #{msg}"
end

conn.close
