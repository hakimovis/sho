module Api
  module V1
    class AbstractController < ApplicationController
      def render_success(data = nil)
        render json: {status: 'ok', data: data}.compact
      end

      def render_error(error, message = nil)
        render json: {status: error, message: message}.compact
      end
    end
  end
end