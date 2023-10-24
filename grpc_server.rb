# frozen_string_literal: true

require_relative './lib/user_services_pb'

class ServerImpl < UserManager::Service
  def get(user_request, _call)
    user = User.new(
      id: user_request.id,
      nickname: 'Michael',
      mail_address: 'example.com',
      user_type: 0,
      user_icon: [
        Picture.new(id: 1, width: 100, height: 100, type: 0),
        Picture.new(id: 2, width: 100, height: 100, type: 1),
        Picture.new(id: 3, width: 100, height: 100, type: 2),
      ],
      default_picture: 1,
    )
    UserResponse.new(error: false, message: '', user: user)
  end
end


port = '0.0.0.0:50051'
s = GRPC::RpcServer.new
s.add_http2_port(port, :this_port_is_insecure)
GRPC.logger.info("... running insecurely on #{port}")
s.handle(ServerImpl.new)
# Runs the server with SIGHUP, SIGINT and SIGQUIT signal handlers to
#   gracefully shutdown.
# User could also choose to run server via call to run_till_terminated
s.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
