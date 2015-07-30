module Api
  module V1
    class TonightController < ApplicationController

      def show
        @tonight = Tonight.find_or_create
      end

    end
  end
end
