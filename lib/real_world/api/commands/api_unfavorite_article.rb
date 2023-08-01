# frozen_string_literal: true

require 'colmena/command'
require 'real_world/api/queries/support'

module RealWorld
  module Api
    module Commands
      class ApiUnfavoriteArticle < Colmena::Command
        def call(auth_token:, slug:)
          token, error = port(:tokens).decode_auth(auth_token)
          return error_response(:unauthorized, reason: error) if error

          read_article = port(:router).query(:read_article_by_slug).call(
            slug: slug,
          )

          capture_errors(read_article) do
            article = read_article.fetch(:data)

            unfavorite_article = port(:router).command(:unfavorite_article).call(
              id: article.fetch(:id),
              user_id: token.fetch(:user_id),
            )

            capture_errors(unfavorite_article) do
              response(port(:router).query(:api_get_article).call(
                auth_token: auth_token,
                slug: slug,
              ).fetch(:data))
            end
          end
        end
      end
    end
  end
end
