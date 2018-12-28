class AccessTokensController < ApplicationController
  def create
    error = {
              "status" => "401",
              "source" => { "pointer" => "/code" },
              "title" => "Authentication code is invalid",
              "detail" => "You must provide a valid code in order to exchange it for a token."
            }
    render json: { "errors": [ error ] }, status: 401
  end
end
