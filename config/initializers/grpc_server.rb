# frozen_string_literal: true

require 'grpc'

port = '0.0.0.0:50051'
s = GRPC::RpcServer.new
s.add_http2_port(port, :this_port_is_insecure)
GRPC.logger.info("... running insecurely on #{port}")
s.handle(Api::Grpc::ArticlesController.new)
s.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
