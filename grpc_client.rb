# frozen_string_literal: true

require_relative './lib/user_services_pb'

user_stub = UserManager::Stub.new('localhost:50051', :this_channel_is_insecure)
resp = user_stub.get(UserRequest.new(id: 1))

puts resp.class
puts resp
