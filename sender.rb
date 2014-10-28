# -*- coding:utf-8 -*-
#
require 'bundler/setup'
require 'bunny'

conn = Bunny.new
conn.start

ch = conn.create_channel

q = ch.queue('hello')
10000.times do |a|
  ch.default_exchange.publish("#{"Hello World!#{a}th"}", :routing_key => q.name)
end
puts 'sent!'

conn.close
