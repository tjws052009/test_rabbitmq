# -*- coding:utf-8 -*-
#
# ここのコードを利用
# http://www.rabbitmq.com/tutorials/tutorial-three-ruby.html
#
require 'bundler/setup'
require 'bunny'

conn = Bunny.new
conn.start

ch = conn.create_channel
x = ch.fanout("logs")
q = ch.queue('')

q.bind(x)

puts " [*] Waiting for logs. To exit press CTRL+C"

begin
  q.subscribe(:block => true) do |delivery_info, properties, body|
    puts " [x] [#{Time.now.to_i}] #{body}"
  end
rescue Interrupt => _
  ch.close
  conn.close
end
