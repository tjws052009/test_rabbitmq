# -*- coding:utf-8 -*-
#
require 'bundler/setup'
require 'bunny'

conn = Bunny.new
conn.start

ch = conn.create_channel

q = ch.queue('hello')
puts "#{q.name}"
q.subscribe(:block => true) do |delivery_info, properties, body|
  puts "Received: #{body}"

  # delivery_info.consumer.cancel
end
