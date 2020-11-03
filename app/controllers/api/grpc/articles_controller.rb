# frozen_string_literal: true

this_dir = __dir__
lib_dir = File.join(File.dirname(this_dir), 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'article_services_pb'

class Api::Grpc::ArticlesController < Grpcapi::Articles::Articles::Service
  include Grpcapi::Articles

  def get_feature(id, _call)
    article = ::Article.find(id.id)
    FullContent.new(
      id: article.id,
      title: article.title,
      created_at: article.created_at,
      updated_at: article.updated_at
    )
  end

  def list_features(_rectangle, _call)
    ::Article.all.each do |article|
      yield article
    end
  end
end
